import 'package:ejercicio_grupal/builders/director.dart';
import 'package:ejercicio_grupal/builders/burrata_builder.dart';
import 'package:ejercicio_grupal/builders/margarita_builder.dart';
import 'package:ejercicio_grupal/builders/pepperoni_builder.dart';
import 'package:ejercicio_grupal/builders/pistacho_buider.dart';
import 'package:ejercicio_grupal/builders/tartufa_builder.dart';
import 'package:ejercicio_grupal/builders/vegetal_builder.dart';

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
            foto: 'assets/pepperoni.jpg',
          ),
          PizzaConFoto(
            pizza: Director(BurrataPesto()).build(''),
            foto: 'assets/burrata.jpg',
          ),
          PizzaConFoto(
            pizza: Director(Tartufa()).build(''),
            foto: 'assets/tartufa.webp',
          ),
          
          PizzaConFoto(
            pizza: Director(Pistacho()).build(''),
            foto: 'assets/pistacho.JPEG',
          ),
          
          PizzaConFoto(
            pizza: Director(Vegetal()).build(''),
            foto: 'assets/vegetal.webp',
          )
          
          // Añade más pizzas por aquii
        ];

  void addPizza(Pizza pizza, String foto) {
    pizzas.add(PizzaConFoto(pizza: pizza, foto: foto));
  }

  void removePizza(String nombrePizza) {
    pizzas.removeWhere(
        (pizzaConFoto) => pizzaConFoto.pizza.nombre == nombrePizza);
  }
}
