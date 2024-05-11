import 'package:ejercicio_grupal/builders/pizza_builder.dart';
import 'package:ejercicio_grupal/models/pizza.dart';

class Director {
  final PizzaBuilder builder;

  Director(this.builder);

  Pizza build(String tamano) {
    builder.createPizza();
    builder.setNombre();
    builder.setPrecio();
    builder.setTamano(tamano);
    builder.setIngredientes();
    return builder.getPizza();
  }
}
