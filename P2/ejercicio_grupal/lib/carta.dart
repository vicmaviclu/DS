import 'models/pizza.dart';

class Carta {
  List<Pizza> pizzas;

  Carta(this.pizzas);

  void addPizza(Pizza pizza) {
    pizzas.add(pizza);
  }

  void removePizza(Pizza pizza) {
    pizzas.remove(pizza);
  }

  void updatePizza(Pizza oldPizza, Pizza newPizza) {
    int index = pizzas.indexOf(oldPizza);
    if (index != -1) {
      pizzas[index] = newPizza;
    }
  }
}
