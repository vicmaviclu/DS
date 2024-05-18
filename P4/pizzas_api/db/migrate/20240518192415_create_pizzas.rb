class CreatePizzas < ActiveRecord::Migration[7.1]
  def change
    create_table :pizzas do |t|
      t.string :nombre
      t.string :tamano
      t.decimal :coste
      t.references :pedido, null: false, foreign_key: true

      t.timestamps
    end
  end
end
