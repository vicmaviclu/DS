import 'package:ejercicio_grupal/models/pizza.dart';

abstract class PizzaBuilder {
  late Pizza pizza;

  void createPizza() {
    pizza = Pizza();
  }

  void setNombre();
  void setPrecio();
  void setTamano(String tamano);
  void setIngredientes();
  void setIngredientesAdicionales(List<String> ingredientes);

  Pizza getPizza() {
    return this.pizza;
  }
}
