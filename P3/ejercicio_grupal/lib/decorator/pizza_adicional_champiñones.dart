import 'pizza_decorator.dart';
import '../models/pizza.dart';

class PizzaAdicionalChampinones extends PizzaDecorator {
  final String ingrediente = 'Champiñones Extra';
  PizzaAdicionalChampinones(Pizza pizza) : super(pizza);

  @override
  void updateDescription() {
    pizza.addIngrediente(ingrediente);
  }

  @override
  void updateCoste() {
    pizza.updatePrecio(costeAdicional);
  }
}
