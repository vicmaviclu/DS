class RemoveNumeroPedidoFromPedidos < ActiveRecord::Migration[7.1]
  def change
    remove_column :pedidos, :numero_pedido, :integer
  end
end
