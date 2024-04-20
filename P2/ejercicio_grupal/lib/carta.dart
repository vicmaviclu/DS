import 'package:ejercicio_grupal/builders/director.dart';
import 'package:ejercicio_grupal/builders/hawaiana_builder.dart';
import 'package:ejercicio_grupal/builders/margarita_builder.dart';
import 'package:ejercicio_grupal/builders/pepperoni_builder.dart';

import 'models/pizza.dart';
import 'models/pizza_foto.dart';

// Carta clase singleton
class Carta {
  List<PizzaConFoto> pizzas;
  Map<String, double> costesAdicionales = {
    'Mediana': 1.0,
    'Grande': 2.0,
    'Gigante': 3.0,
  };

  static final Carta _singleton = Carta._internal();

  factory Carta() {
    return _singleton;
  }

  Carta._internal()
      : pizzas = [
          PizzaConFoto(
            pizza: Director(MargaritaBuilder()).build(''),
            foto: 'assets/margarita.jpg',
            
          ),
          PizzaConFoto(
            pizza: Director(PepperoniBuilder()).build(''),
            foto: 'assets/descarga.png',
          ),
          PizzaConFoto(
            pizza: Director(HawaianaBuilder()).build(''),
            foto: 'assets/descarga.png',
          )
          // Añade más pizzas aquí...
        ];

  void addPizza(Pizza pizza, String foto) {
    pizzas.add(PizzaConFoto(pizza: pizza, foto: foto));
  }

  void removePizza(String nombrePizza) {
    pizzas.removeWhere(
        (pizzaConFoto) => pizzaConFoto.pizza.nombre == nombrePizza);
  }

  double getCoste(String nombrePizza, String tamano) {
    for (var pizzaConFoto in pizzas) {
      if (pizzaConFoto.pizza.nombre == nombrePizza) {
        double precioBase = pizzaConFoto.pizza.precio;
        double costeAdicional = costesAdicionales[tamano] ?? 0.0;
        return precioBase + costeAdicional;
      }
    }
    return 0.0;
  }
}
