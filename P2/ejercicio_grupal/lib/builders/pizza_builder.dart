import 'package:ejercicio_grupal/models/pizza.dart';

abstract class PizzaBuilder {
  Pizza? pizza;
  void createNewPizza();
  void addIngredientes(List<String> ingredientes);
}
