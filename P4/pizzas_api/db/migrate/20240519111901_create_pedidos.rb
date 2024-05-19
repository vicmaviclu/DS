class CreatePedidos < ActiveRecord::Migration[7.1]
  def change
    create_table :pedidos do |t|
      t.integer :numero_pedido
      t.string :numero_telefono
      t.boolean :pedido_realizado
      t.string :direccion
      t.string :tarjeta

      t.timestamps
    end
  end
end
