import '../models/pizza.dart';

abstract class PizzaDecorator extends Pizza {
  Pizza pizza;
  final double costeAdicional = 0.5;

  PizzaDecorator(this.pizza);

  void updateDescription();

  void updateCoste();

  Pizza get getPizza => pizza;
}
