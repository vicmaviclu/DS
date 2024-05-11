import '/builders/pizza_builder.dart';

class MargaritaBuilder extends PizzaBuilder {
  final String nombre = 'Margarita';
  final double precio = 8.50;
  final List<String> ingredientes = ['Tomate', 'Mozzarella', 'Albahaca'];

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
