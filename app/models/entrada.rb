class Entrada < ApplicationRecord
  belongs_to :pesquisa
  has_many :exemplos, class_name: 'Exemplo'
end
