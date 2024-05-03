import 'pizza_decorator.dart';
import '../models/pizza.dart';

class PizzaAdicionalQueso extends PizzaDecorator {
  final String ingrediente = 'queso extra';
  PizzaAdicionalQueso(Pizza pizza) : super(pizza);

  @override
  void updateDescription() {
    pizza.addIngrediente(ingrediente);
    pizza.ingredientes.add(ingrediente); // Añade el ingrediente a la descripción de la pizza
  }

  @override
  void updateCoste() {
    pizza.updatePrecio(costeAdicional);
  }
}
