class AddCosteTotalToPedidos < ActiveRecord::Migration[7.1]
  def change
    add_column :pedidos, :costeTotal, :decimal
  end
end
