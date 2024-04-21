import '/builders/director.dart';
import '/builders/margarita_builder.dart';
import '/builders/pepperoni_builder.dart';
import '/builders/vegetal_builder.dart';
import '/builders/burrata_builder.dart';
import '/builders/pistacho_buider.dart';
import '/builders/tartufa_builder.dart';
import '/models/pizza.dart';

class PizzaFactory {
  static Pizza createPizza(String pizzaSeleccionada, String tamanoSeleccionado) {
    switch (pizzaSeleccionada) {
      case 'Pizza Margarita':
        return Director(MargaritaBuilder()).build(tamanoSeleccionado);
      case 'Pizza Pepperoni':
        return Director(PepperoniBuilder()).build(tamanoSeleccionado);
      case 'Pizza Vegetariana':
        return Director(Vegetal()).build(tamanoSeleccionado);
      case 'Pizza Burrata Pesto':
        return Director(BurrataPesto()).build(tamanoSeleccionado);
      case 'Pizza Pistacho':
        return Director(Pistacho()).build(tamanoSeleccionado);
      case 'Pizza Tartufa':
        return Director(Tartufa()).build(tamanoSeleccionado);
      default:
        throw Exception('Tipo de pizza no reconocido: $pizzaSeleccionada');
    }
  }
}