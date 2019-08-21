require "rails_helper"

RSpec.describe Pesquisa, :type => :model do

  describe "Associacao" do
    it { should have_many :entradas }
  end

  let!(:palavra) { FactoryGirl.build(:pesquisa, palavra: 'casa') }
  let!(:pesquisa) { Pesquisa.conexao_webservice(palavra.word) }
  let!(:palavra_inexistente) { FactoryGirl.build(:pesquisa, palavra: 'ccassa') }
  let!(:pesquisa_nao_encontrada) { Pesquisa.conexao_webservice(palavra_inexistente.word) }

  #Service is stubbed (see rails helper)
  describe "Scope 'conexao_webservice'" do
      it "retorna um hash com as entradas" do
        expect(pesquisa).to be_instance_of(Hash)
        expect(pesquisa["entry_list"]).to include("entry")
      end

      it "se a busca falhar, retorna a sugestoes" do
        expect(pesquisa_nao_encontrada["entry_list"]).to include("suggestion")
      end
    end

    describe "Scope 'Buscar Palavra'" do
    it "Palavra encontrada no banco" do
    end

    it "palavra nao encontrada no banco, mais encontrada no webservice" do
    end

    it "palavra nao encontrada nem no banco nem no webservice" do
    end
  end

end
