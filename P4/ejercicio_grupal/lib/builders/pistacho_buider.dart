import '/builders/pizza_builder.dart';

class Pistacho extends PizzaBuilder {
  final String nombre = 'Pistacho';
  final double precio = 11.0;
  final List<String> ingredientes = ['Tomate', 'Burrata', 'Pistacho', 'Aceite de oliva', 'Jamón Cocido', 'Rúcula'];

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
