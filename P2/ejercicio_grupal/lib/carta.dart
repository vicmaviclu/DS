import 'models/pizza.dart';

class PizzaConFoto {
  final Pizza pizza;
  final String foto;

  PizzaConFoto({required this.pizza, required this.foto});
}

class Carta {
  List<PizzaConFoto> pizzas;

  Carta() : pizzas = [
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
    PizzaConFoto(
      pizza: Pizza(
        nombre: 'Pepperoni',
        precio: 9.00,
        ingredientes: ['Tomate', 'Mozzarella', 'Pepperoni'],
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
}