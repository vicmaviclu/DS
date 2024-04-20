import 'package:ejercicio_grupal/builders/pizza_builder.dart';

class Tartufa extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Tartufa';
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
    pizza.ingredientes = ['Tomate', 'Queso Pecorino', 'Trufa Negra', 'Aceite de Trufa'];
  }

  
  @override
  void setIngredientesAdicionales( List<String> ingredientesAdicionales) {
    pizza.ingredientes.addAll(ingredientesAdicionales);
    
  }
}
