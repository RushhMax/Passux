class PostController < ApplicationController
  #before_action :require_login  # Verifica que el usuario haya iniciado sesión antes de ejecutar cualquier acción

  def posts
    
  end

  def new
    @publicacion = Publicacion.new  # Inicializa una nueva instancia de Publicacion
  end

  def create
    @publicacion = current_usuario.publicaciones.build(publicacion_params)  # Construye una nueva publicación asociada al usuario actual

    if @publicacion.save
      redirect_to new_publicacion_path, notice: "Publicación creada exitosamente."  # Redirige al formulario de nueva publicación con un mensaje de éxito
    else
      flash.now[:alert] = "No se pudo guardar la publicación. Revisa los errores:"  # Muestra un mensaje de error si la publicación no se pudo guardar
      @publicacion.errors.full_messages.each do |message|
        flash.now[:alert] += " #{message}."  # Agrega los mensajes de error específicos a la alerta
      end
      render :new  # Renderiza nuevamente el formulario de nueva publicación
    end
  rescue StandardError => e
    flash.now[:alert] = "Error al guardar la publicación: #{e.message}"  # Muestra un mensaje de error en caso de una excepción
    render :new  # Renderiza nuevamente el formulario de nueva publicación
  end

  private

  def publicacion_params
    params.require(:publicacion).permit(:contenido)  # Permite solo el parámetro contenido para la publicación
  end

  def require_login
    unless current_usuario
      redirect_to login_path, alert: "Debes iniciar sesión para acceder a esta página."  # Redirige al formulario de login si el usuario no ha iniciado sesión
    end
  end
end