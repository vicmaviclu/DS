import 'package:ejercicio_grupal/builders/pizza_builder.dart';

class Pistacho extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Pistacho';
  }

  @override
  void setPrecio() {
    pizza.precio = 11.0;
  }

  @override
  void setTamano(String tamano) {
    pizza.tamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.ingredientes = ['Tomate', 'Burrata', 'Pistacho', 'Aceite de oliva', 'Jamón Cocido', 'Rúcula'];
  }

  
  @override
  void setIngredientesAdicionales( List<String> ingredientesAdicionales) {
    pizza.ingredientes.addAll(ingredientesAdicionales);
    
  }
}
