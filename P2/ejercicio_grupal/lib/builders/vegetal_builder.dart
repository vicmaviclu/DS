import '/builders/pizza_builder.dart';

class Vegetal extends PizzaBuilder {
  final String nombre = 'Vegetal';
  final double precio = 8.0;
  final List<String> ingredientes = ['Tomate', 'Mozzarella', 'Rucula', 'Tomate Cherry','Aceite de Oliva'];

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