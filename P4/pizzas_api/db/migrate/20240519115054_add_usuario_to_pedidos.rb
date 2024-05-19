class AddUsuarioToPedidos < ActiveRecord::Migration[7.1]
  def change
    add_column :pedidos, :usuario, :string
  end
end
