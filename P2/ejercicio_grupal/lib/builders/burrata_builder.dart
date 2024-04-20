import 'package:ejercicio_grupal/builders/pizza_builder.dart';

class BurrataPesto extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Burrata Pesto';
  }

  @override
  void setPrecio() {
    pizza.precio = 9.0;
  }

  @override
  void setTamano(String tamano) {
    pizza.tamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.ingredientes = ['Pesto', 'Burrata', 'Aceite de Oliva', 'Tomate Cherry'];
  }
}
