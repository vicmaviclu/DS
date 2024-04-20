import 'package:ejercicio_grupal/builders/pizza_builder.dart';

class HawaianaBuilder extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Hawaiana';
  }

  @override
  void setPrecio() {
    pizza.precio = 8.0;
  }

  @override
  void setTamano(String tamano) {
    pizza.tamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.ingredientes = ['Tomate', 'Jamon', 'Piña'];
  }
}
