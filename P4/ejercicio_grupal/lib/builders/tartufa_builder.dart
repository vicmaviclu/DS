import '/builders/pizza_builder.dart';

class Tartufa extends PizzaBuilder {
  final String nombre = 'Tartufa';
  final double precio = 11.0;
  final List<String> ingredientes = ['Tomate', 'Queso Pecorino', 'Trufa Negra', 'Aceite de Trufa'];

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
