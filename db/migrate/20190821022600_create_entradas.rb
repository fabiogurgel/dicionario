class CreateEntradas < ActiveRecord::Migration[5.2]
  def change
    create_table :entradas do |t|
      t.string :word
      t.string :grammar_group
      t.references :pesquisa, index: true, foreign_key: true
    end
  end
end
