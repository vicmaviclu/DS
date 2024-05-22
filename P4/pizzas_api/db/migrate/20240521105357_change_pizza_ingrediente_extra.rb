class ChangePizzaIngredienteExtra < ActiveRecord::Migration[6.0]
  def change
    remove_column :pizza_ingrediente_extras, :ingrediente_extra_id
    add_column :pizza_ingrediente_extras, :nombre, :string
  end
end