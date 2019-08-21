class Pesquisa < ApplicationRecord
  has_many :entradas, class_name: 'Entrada'

  # Retorna um hash com as sugestoes encontradas
  # formato do retorno: { lista_de_entradas: { version: '1.0', sugetoes: ['sugestao1', 'sugestao2'] }}
  def self.conexao_webservice(palavra)
    key = 'key=22db59d8-2b84-4309-849e-50978735b453'
    url = 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/'
    uri = URI("#{url}#{palavra}?#{key}")
    response = Net::HTTP.get(uri)
    return Hash.from_xml(response)
  end

  def self.salvar_pesquisa(palavra, dados)
    pesquisa = Pesquisa.new(palavra: palavra)
    dados['entry_list']['entry'].each do |dados_entrada|
      entrada = Entrada.new(palavra: dados_entrada['ew'].to_s, grammar_group: dados_entrada['fl'].to_s)
      if dados_entrada['def']['dt'].instance_of?(Array)
        dados_entrada['def']['dt'].each do |dados_exemplo|
          exemplo = Exemplo.new(texto: dados_exemplo)
          entrada.exemplos << exemplo
        end
      else
        entrada.exemplos << Exemplo.new(texto: dados_entrada['def']['dt'])
      end
      pesquisa.entradas << entrada
    end
    return pesquisa.save
end

  # Busca palavras no Banco
  # Se nao existir, busca no webservice
  # Se nao existir, retorna as sugestoes do webservice
def self.buscar_palavra(palavra)
    resultado = Hash.new
    pesquisa = Pesquisa.find_by(word: palavra)
    if pesquisa.nil?
      resposta = conexao_webservice(palavra)
      #word not on database but is found on the webservice
      if resposta['entry_list'].include?('entry')
        salvar_pesquisa(palavra, resposta)
        return buscar_palavra(palavra)
      else
        #word is neither on database and webservice
        resultado['found'] = false
        resultado['data'] = resposta['entry_list']
        return resultado
      end
    else
      #word is in database and will be passed through data
      resultado["found"] = true
      resultado["data"] = pesquisa
    end
    return resultado
  end
end
