class RemovePedidoRealizadoFromPedidos < ActiveRecord::Migration[7.1]
  def change
    remove_column :pedidos, :pedido_realizado, :boolean
  end
end
