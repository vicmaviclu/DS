import 'pizza_builder.dart';

class MargaritaBuilder extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Margarita';
  }

  @override
  void setPrecio() {
    pizza.precio = 8.50;
  }

  @override
  void setTamano(String tamano) {
    pizza.tamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.ingredientes = ['Tomate', 'Mozzarella', 'Albahaca'];
  }

  
  @override
  void setIngredientesAdicionales( List<String> ingredientesAdicionales) {
    pizza.ingredientes.addAll(ingredientesAdicionales);
    
  }
}
