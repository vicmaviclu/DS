import '/builders/pizza_builder.dart';

class BurrataPesto extends PizzaBuilder {
  final String nombre = 'Burrata Pesto';
  final double precio = 9.0;
  final List<String> ingredientes = ['Pesto', 'Burrata', 'Aceite de Oliva', 'Tomate Cherry'];

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
