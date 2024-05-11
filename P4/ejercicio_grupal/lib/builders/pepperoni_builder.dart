import '/builders/pizza_builder.dart';

class PepperoniBuilder extends PizzaBuilder {
  final String nombre = 'Pepperoni';
  final double precio = 9.0;
  final List<String> ingredientes = ['Tomate', 'Mozzarella', 'Pepperoni'];

  @override
  void setNombre() {
    pizza.setNombre = nombre;
  }

  @override
  void setPrecio() {
    pizza.setPrecio = precio;
  }

  @override
  void setTamano(String tamano) {
    pizza.setTamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.setIngredientes = ingredientes;
  }
}

