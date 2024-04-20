import 'package:ejercicio_grupal/builders/pizza_builder.dart';
import 'package:ejercicio_grupal/models/pizza.dart';

class Director {
  PizzaBuilder _builder;

  Director(this._builder);

  Pizza build(String tamano) {
    _builder.createPizza();
    _builder.setNombre();
    _builder.setPrecio();
    _builder.setTamano(tamano);
    _builder.setIngredientes();
    return _builder.getPizza();
  }
}
