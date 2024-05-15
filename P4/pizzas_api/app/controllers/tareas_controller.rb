class TareasController < ApplicationController
  def index
    #@tareas = Tarea.where(usuario: params[:usuario])
    @tareas = Tarea.all
    logger.info "Cargando tareas para usuario: #{params[:usuario]}, Total: #{@tareas.count}"
    render json: @tareas
  end

  def create
    @tarea = Tarea.new(tarea_params)
    if @tarea.save
      render json: @tarea, status: :created
    else
      render json: @tarea.errors, status: :unprocessable_entity
    end
  end


  def update
    @tarea = Tarea.find(params[:id])
    if @tarea.update(tarea_params)
      render json: @tarea
    else
      render json: @tarea.errors, status: :unprocessable_entity
    end
  end

  def destroy
    tarea = Tarea.find(params[:id])
    if tarea.destroy
      head :ok
    else
      render json: { error: "Failed to delete" }, status: :unprocessable_entity
    end
  end



  private

  def tarea_params
     params.require(:tarea).permit(:descripcion, :completada, :usuario)
  end
end
