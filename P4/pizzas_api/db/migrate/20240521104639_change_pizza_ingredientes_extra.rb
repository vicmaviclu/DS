class ChangePizzaIngredientesExtra < ActiveRecord::Migration[6.0]
  def change
    remove_column :pizza_ingredientes_extra, :ingrediente_extra_id
    add_column :pizza_ingredientes_extra, :nombre, :string
  end
end