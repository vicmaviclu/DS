import 'pizza.dart';

class PizzaConFoto {
  final Pizza pizza;
  final String foto;
  final double imageSize;
  final List<String> ingredientesAdicionales; // Nueva lista para ingredientes adicionales

  PizzaConFoto({required this.pizza, required this.foto, this.imageSize = 100.0, this.ingredientesAdicionales = const []});
}