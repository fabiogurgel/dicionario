class CreateExemplos < ActiveRecord::Migration[5.2]
  def change
    create_table :exemplos do |t|
      t.string :text
      t.references :entrada, index: true, foreign_key: true
    end
  end
end
