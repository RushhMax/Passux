#**Laboratorio 9**

## Objetivo: Demostrar bugs, code smells y vulnerabilities y corregirlos aplicando prácticas de codificación legible en el  proyecto que esta siendo desarrollado como proyecto final de curso.

## **Variables**
### Use meaningful and pronounceable variable names

**Bad:**
```ruby
yyyymmdstr = Time.now.strftime('%Y/%m/%d')
```

**Good:**
```ruby
current_date = Time.now.strftime('%Y/%m/%d')
```

## **Nombres**

### **Nombre de rutas:**
Segun los protocolos de inflexión utilizamos el lenguaje ingles para poder dar una ventaja a la lógica que esta utilizando nuestro interprete
Por eso mi modelo "Publicaciones", lo nombro como Post.
```ruby
  get "Hola" => "post#" # Controlador Welcome hello
```

### **Nombre del Archivo:**
```ruby
post_controller.rb:
```

### **Nombre de Clase:**
Para Rubi se utiliza la notación de las primeras letras en mayuscula y no utilizar ningun espacio entre ellas.
```ruby
class PostController
  
end
```

### **Funciones**
### Metodos solo deberian hacer una cosa

**Bad:**
```ruby
def email_clients(clients)
  clients.each do |client|
    client_record = database.lookup(client)
    email(client) if client_record.active?
  end
end

email_clients(clients)
```

**Good:**
```ruby
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

```

## **Objetos y estructuras de datos**
### Use getters and setters

**Bad:**
```ruby
def make_bank_account
  # ...

  {
    balance: 0
    # ...
  }
end

account = make_bank_account
account[:balance] = 100
account[:balance] # => 100
```

**Good:**
```ruby
class BankAccount
  def initialize
    # this one is private
    @balance = 0
  end

  # a "getter" via a public instance method
  def balance
    # do some logging
    @balance
  end

  # a "setter" via a public instance method
  def balance=(amount)
    # do some logging
    # do some validation
    @balance = amount
  end
end

account = BankAccount.new
account.balance = 100
account.balance # => 100
```