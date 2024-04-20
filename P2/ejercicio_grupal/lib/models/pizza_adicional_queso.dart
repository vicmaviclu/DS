import 'pizza_decorator.dart';
import 'pizza.dart';

class PizzaAdicionalQueso extends PizzaDecorator {
  final String ingrediente = 'queso extra';
  PizzaAdicionalQueso(Pizza pizza) : super(pizza);


  @override
  void updateDescription() {
    pizza.addIngrediente(ingrediente);
  }

  @override
  void updateCoste() {
    pizza.updatePrecio(costeAdicional);
  }
}