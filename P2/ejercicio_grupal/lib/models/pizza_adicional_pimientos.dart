import 'pizza_decorator.dart';
import 'pizza.dart';

class PizzaAdicionalPimientos extends PizzaDecorator {
  final String ingrediente = 'Pimientos Extra';
  PizzaAdicionalPimientos(Pizza pizza) : super(pizza);


  @override
  void updateDescription() {
    pizza.addIngrediente(ingrediente);
  }

  @override
  void updateCoste() {
    pizza.updatePrecio(costeAdicional);
  }
}