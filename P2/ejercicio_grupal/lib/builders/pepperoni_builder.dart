import 'pizza_builder.dart';

class PepperoniBuilder extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Pepperoni';
  }

  @override
  void setPrecio() {
    pizza.precio = 9.00;
  }

  @override
  void setTamano(String tamano) {
    pizza.tamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.ingredientes = ['Tomate', 'Mozzarella', 'Pepperoni'];
  }

  
  @override
  void setIngredientesAdicionales( List<String> ingredientesAdicionales) {
    pizza.ingredientes.addAll(ingredientesAdicionales);
    
  }
}
