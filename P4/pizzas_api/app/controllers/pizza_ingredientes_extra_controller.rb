class PizzaIngredientesExtraController < ApplicationController
  def index
    @pizza_ingredientes_extra = PizzaIngredienteExtra.all
    logger.info "Cargando ingredientes extra, Total: #{@pizza_ingredientes_extra.count}"
    render json: @pizza_ingredientes_extra
  end

  def show
    @pizza = Pizza.find(params[:id])
    @pizza_ingredientes_extra = PizzaIngredienteExtra.where(pizza_id: @pizza.id)
    render json: @pizza_ingredientes_extra
  end

  def create
    @pizza_ingrediente_extra = PizzaIngredienteExtra.new(pizza_ingrediente_extra_params)

    if @pizza_ingrediente_extra.save
      render json: @pizza_ingrediente_extra, status: :created
    else
      render json: @pizza_ingrediente_extra.errors, status: :unprocessable_entity
    end
  end

  def update
    @pizza_ingrediente_extra = PizzaIngredienteExtra.find(params[:id])
    if @pizza_ingrediente_extra.update(ingrediente_extra_params)
      render json: @pizza_ingrediente_extra
    else
      render json: @pizza_ingrediente_extra.errors, status: :unprocessable_entity
    end
  end

  def destroy
    pizza_ingrediente_extra = PizzaIngredienteExtra.find(params[:id])
    if pizza_ingrediente_extra.destroy
      head :ok
    else
      render json: { error: "Failed to delete" }, status: :unprocessable_entity
    end
  end

  private
  def pizza_ingrediente_extra_params
    params.require(:pizza_ingrediente_extra).permit(:nombre, :pizza_id)
  end
end