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

  Carta._internal() : pizzas = [
    PizzaConFoto(
      pizza: Pizza(
        nombre: 'Margarita',
        precio: 8.50,
        ingredientes: ['Tomate', 'Mozzarella', 'Albahaca'],
        tamano: '',
      ),
      foto: 'assets/descarga.png',
    ),
    PizzaConFoto(
      pizza: Pizza(
        nombre: 'Pepperoni',
        precio: 9.00,
        ingredientes: ['Tomate', 'Mozzarella', 'Pepperoni'],
        tamano: '',
      ),
      foto: 'assets/descarga.png',
    ),
    // Añade más pizzas aquí...
  ];

  void addPizza(Pizza pizza, String foto) {
    pizzas.add(PizzaConFoto(pizza: pizza, foto: foto));
  }

  void removePizza(String nombrePizza) {
    pizzas.removeWhere((pizzaConFoto) => pizzaConFoto.pizza.nombre == nombrePizza);
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