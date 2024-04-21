import '/models/pizza.dart';
import 'package:ejercicio_grupal/decorator/pizza_decorator.dart';
import 'decorator/pizza_adicional_queso.dart';
import 'decorator/pizza_adicional_aceitunos.dart';
import 'decorator/pizza_adicional_champiñones.dart';
import 'decorator/pizza_adicional_pimientos.dart';
import 'decorator/pizza_adicional_cebolla.dart';

class PizzaExtras {
  static void anadirExtras(
      Pizza pizza, List<String> ingredientesAdicionalesSeleccionados) {
    final ingredientesAMetodos = {
      'Aceitunas': (Pizza p) => PizzaAdicionalAceituna(p),
      'Champiñones': (Pizza p) => PizzaAdicionalChampinones(p),
      'Pimientos': (Pizza p) => PizzaAdicionalPimientos(p),
      'Cebolla': (Pizza p) => PizzaAdicionalCebolla(p),
      'Extra queso': (Pizza p) => PizzaAdicionalQueso(p),
    };

    for (var ingrediente in ingredientesAdicionalesSeleccionados) {
      if (ingredientesAMetodos.containsKey(ingrediente)) {
        pizza = ingredientesAMetodos[ingrediente]!(pizza);
      }
    }

    actualizar(pizza as PizzaDecorator);
  }

  // Método para actualizar la descripción y el coste de la pizza
  static void actualizar(PizzaDecorator pizza) {
    pizza.updateDescription();
    pizza.updateCoste();
  }
}
