class PesquisasController < ApplicationController
    def index
    end

    def buscar_palavra
        @resultado = Pesquisa.buscar_palavra(buscar_palavra_params)
        responde_to do |formart|
            format.js
        end
    end

     # Parametros aceitos
     private

     def buscar_palavra_params
       params.require(:pesquisa).permit(:palavra)
     end
end
