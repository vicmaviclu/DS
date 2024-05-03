import 'pizza_decorator.dart';
import '../models/pizza.dart';

class PizzaAdicionalCebolla extends PizzaDecorator {
  final String ingrediente = 'Cebolla Extra';
  PizzaAdicionalCebolla(Pizza pizza) : super(pizza);

  @override
  void updateDescription() {
    pizza.addIngrediente(ingrediente);
  }

  @override
  void updateCoste() {
    pizza.updatePrecio(costeAdicional);
  }
}
