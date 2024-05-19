class PedidosController < ApplicationController
    def index
        if params[:usuario]
          @pedidos = Pedido.where(usuario: params[:usuario])
          logger.info "Cargando pedidos para usuario: #{params[:usuario]}, Total: #{@pedidos.count}"
        else
          @pedidos = Pedido.all
          logger.info "Cargando todos los pedidos, Total: #{@pedidos.count}"
        end
        render json: @pedidos
      end
  
    def create
      @pedido = Pedido.new(pedido_params)
      if @pedido.save
        render json: @pedido, status: :created
      else
        render json: @pedido.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @pedido = Pedido.find(params[:id])
      if @pedido.update(pedido_params)
        render json: @pedido
      else
        render json: @pedido.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      pedido = Pedido.find(params[:id])
      if pedido.destroy
        head :ok
      else
        render json: { error: "Failed to delete" }, status: :unprocessable_entity
      end
    end
  
    private
  
    def pedido_params
      params.require(:pedido).permit(:numero_telefono, :direccion, :tarjeta, :usuario)
    end
  end