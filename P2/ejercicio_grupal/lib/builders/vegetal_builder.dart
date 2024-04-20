import 'package:ejercicio_grupal/builders/pizza_builder.dart';

class Vegetal extends PizzaBuilder {
  @override
  void setNombre() {
    pizza.nombre = 'Vegetal';
  }

  @override
  void setPrecio() {
    pizza.precio = 8.0;
  }

  @override
  void setTamano(String tamano) {
    pizza.tamano = tamano;
  }

  @override
  void setIngredientes() {
    pizza.ingredientes = ['Tomate', 'Mozzarella', 'Rucula', 'Tomate Cherry','Aceite de Oliva'];
  }

  
  @override
  void setIngredientesAdicionales( List<String> ingredientesAdicionales) {
    pizza.ingredientes.addAll(ingredientesAdicionales);
    
  }
}
