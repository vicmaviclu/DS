import 'pizza_decorator.dart';
import '../models/pizza.dart';

class PizzaAdicionalAceituna extends PizzaDecorator {
  final String ingrediente = 'Aceitunas Extra';
  PizzaAdicionalAceituna(Pizza pizza) : super(pizza);

  @override
  void updateDescription() {
    pizza.addIngrediente(ingrediente);
  }

  @override
  void updateCoste() {
    pizza.updatePrecio(costeAdicional);
  }
}
