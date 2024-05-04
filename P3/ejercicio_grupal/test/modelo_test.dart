import 'dart:math';

import 'package:ejercicio_grupal/builders/director.dart';
import 'package:ejercicio_grupal/builders/margarita_builder.dart';
import 'package:ejercicio_grupal/decorator/pizza_adicional_queso.dart';
import 'package:ejercicio_grupal/factory/pizza_factory.dart';
import 'package:ejercicio_grupal/models/pizza_extras.dart';
import 'package:ejercicio_grupal/models/pizza_foto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ejercicio_grupal/models/pizza.dart';
import 'package:ejercicio_grupal/decorator/pizza_decorator.dart';
import 'package:ejercicio_grupal/models/pedido.dart';

void main() {
  group("Comprobacion pizzas", () {
    Pizza? pizza;
    const margaritaName = 'Pizza Margarita';
    const mediumSize = 'Mediana';
    const margaritaPrice = 8.5;
    const margaritaIngredients = ['Tomate', 'Mozzarella', 'Albahaca'];

    setUp(() {
      pizza = Pizza();
    });

    void checkPizza(Pizza pizza, String name, double price,
        List<String> ingredients, String size) {
      expect(pizza.getNombre, name);
      expect(pizza.getPrecio, price);
      expect(pizza.getIngredientes, ingredients);
      expect(pizza.getTamano, size);
    }

    test('Valores por defecto de pizza', () {
      checkPizza(pizza!, 'Pizza ', 0.0, [], '');
    });

    test('Pizza con foto', () {
      final foto = 'assets/margarita.jpg';
      final pizzaConFoto = PizzaConFoto(pizza: pizza!, foto: foto);
      expect(pizzaConFoto.foto, foto);
    });

    test('Builder de pizza', () {
      pizza = Director(MargaritaBuilder()).build(mediumSize);
      checkPizza(pizza!, margaritaName, margaritaPrice, margaritaIngredients,
          mediumSize);
    });

    test('Factoria de pizza', () {
      pizza = PizzaFactory.createPizza(margaritaName, mediumSize);
      checkPizza(pizza!, margaritaName, margaritaPrice, margaritaIngredients,
          mediumSize);
    });

    test('Decorador de pizza', () {
      pizza = PizzaFactory.createPizza(margaritaName, mediumSize);

      PizzaAdicionalQueso(pizza!).updateCoste();
      PizzaAdicionalQueso(pizza!).updateDescription();

      checkPizza(pizza!, margaritaName, margaritaPrice + 0.5,
          margaritaIngredients + ['queso extra'], mediumSize);
    });

    test('Pizza extra', () {
      pizza = PizzaFactory.createPizza(margaritaName, mediumSize);

      PizzaExtras.anadirExtras(pizza!, ['Extra queso']);

      checkPizza(pizza!, margaritaName, margaritaPrice + 0.5,
          margaritaIngredients + ['queso extra'], mediumSize);
    });
  });

  group("Comprobacion APP", () {
    Pizza? pizza, pizza2;
    const mediumSize = 'Mediana';

    setUp(() {
      var tempPizza = Director(MargaritaBuilder()).build(mediumSize);
      var tempPizza2 = Director(MargaritaBuilder()).build(mediumSize);
      if (tempPizza != null && tempPizza2 != null) {
        pizza = tempPizza;
        pizza2 = tempPizza2;
        PizzaExtras.anadirExtras(pizza!, ['Extra queso']);
      }
    });

    group('Realizar Pedido', () {
      test('Pedido realizado', () {
        if (pizza != null && pizza2 != null) {
          var pizzas = [pizza!, pizza2!];
          var pedido = Pedido(
            pizzas: pizzas,
            direccion: '123 Calle Falsa',
            tarjeta: '1234567812345678',
            numeroTelefono: '1234567890',
          );

          pedido.hacerPedido();

          expect(pedido.pedidoRealizado, isTrue);
        }
      });

      test('Comprobar Coste Total', () {
        if (pizza != null && pizza2 != null) {
          var pizzas = [pizza!, pizza2!];
          var pedido = Pedido(
            pizzas: pizzas,
            direccion: '123 Calle Falsa',
            tarjeta: '1234567812345678',
            numeroTelefono: '1234567890',
          );

          pedido.hacerPedido();

          var costeTotalEsperado =
              pizza!.getCoste(pizza!.tamano) + pizza2!.getCoste(pizza2!.tamano);
          expect(pedido.getCosteTotal(), costeTotalEsperado);
        }
      });
    });

    test('miau', () {
    });
    test('miu', () {
    });
    test('miau', () {
    });
    test('mi', () {
    });
    
  });
}
