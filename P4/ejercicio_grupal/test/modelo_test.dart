import 'package:ejercicio_grupal/builders/director.dart';
import 'package:ejercicio_grupal/builders/margarita_builder.dart';
import 'package:ejercicio_grupal/builders/pepperoni_builder.dart';
import 'package:ejercicio_grupal/decorator/pizza_adicional_queso.dart';
import 'package:ejercicio_grupal/factory/pizza_factory.dart';
import 'package:ejercicio_grupal/models/pizza_extras.dart';
import 'package:ejercicio_grupal/models/pizza_foto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ejercicio_grupal/models/pizza.dart';
import 'package:ejercicio_grupal/models/pedido.dart';
import 'package:ejercicio_grupal/models/carta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group("Comprobacion pizzas", () {
    Pizza? pizza;
    const id = 84;
    const nombre = 'Pizza Margarita';
    const tamano = 'Mediana';
    const precio = 8.5;
    const ingredientes = ['Tomate', 'Mozzarella', 'Albahaca'];

    // setUp(() {
    //   pizza = Pizza();
    // });

    setUp(() async {
      pizza =
          Pizza(id: id, nombre: 'Pepperoni', precio: precio, tamano: tamano);

      await pizza!.anadirPizza('http://localhost:3000');

      final response =
          await http.get(Uri.parse('http://localhost:3000/pizzas/$id'));
      if (response.statusCode == 200) {
        pizza = Pizza.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load pizza');
      }
    });

    void checkPizza(Pizza pizza, String nombre, double precio,
        List<String> ingredientes, String tamano) {
      expect(pizza.getNombre, nombre);
      expect(pizza.getPrecio, precio);
      expect(pizza.getIngredientes, ingredientes);
      expect(pizza.getTamano, tamano);
    }

    test('Añadir ingrediente extra base de datos', () async {
      pizza!.anadirIngredienteExtra('http://localhost:3000', id, 'Extra queso');
      final response =
          await http.get(Uri.parse('http://localhost:3000/pizzas/$id'));
      if (response.statusCode == 200) {
        pizza = Pizza.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load pizza');
      }
      expect(pizza!.getIngredientesAdicionales, ['Extra queso']);
    });

    test('Valores por defecto de pizza', () {
      checkPizza(pizza!, 'Pizza ', 0.0, [], '');
    });

    test('Pizza con foto', () {
      final foto = 'assets/margarita.jpg';
      final pizzaConFoto = PizzaConFoto(pizza: pizza!, foto: foto);
      expect(pizzaConFoto.foto, foto);
      expect(pizzaConFoto.pizza, pizza);
    });

    test('Builder de pizza', () {
      pizza = Director(MargaritaBuilder()).build(tamano);
      checkPizza(pizza!, nombre, precio, ingredientes, tamano);
    });

    test('Factoria de pizza', () {
      pizza = PizzaFactory.createPizza(nombre, tamano);
      checkPizza(pizza!, nombre, precio, ingredientes, tamano);
    });

    test('Decorador de pizza', () {
      pizza = PizzaFactory.createPizza(nombre, tamano);

      PizzaAdicionalQueso(pizza!).updateCoste();
      PizzaAdicionalQueso(pizza!).updateDescription();

      checkPizza(
          pizza!, nombre, precio + 0.5, ingredientes + ['queso extra'], tamano);
    });

    test('Pizza extra', () {
      pizza = PizzaFactory.createPizza(nombre, tamano);

      PizzaExtras.anadirExtras(pizza!, 'Extra queso');

      checkPizza(
          pizza!, nombre, precio + 0.5, ingredientes + ['queso extra'], tamano);
    });
  });

  group("Comprobacion APP", () {
    const tamano = 'Mediana';
    Pizza? pizza, pizza2;

    setUp(() {
      pizza = Director(MargaritaBuilder()).build(tamano);
      pizza2 = Director(MargaritaBuilder()).build(tamano);
      PizzaExtras.anadirExtras(pizza!, 'Extra queso');
    });

    group('Realizar Pedido', () {
      Pedido? pedido;
      Pizza? pizza, pizza2;
      pizza = Director(MargaritaBuilder()).build('Mediana');
      pizza2 = Director(PepperoniBuilder()).build('Mediana');

      setUp(() {
        pedido = Pedido(
          numeroPedido: 77,
          pizzas: [pizza!, pizza2!],
          direccion: '123 Calle Falsa',
          tarjeta: '1234567812345678',
          numeroTelefono: '1234567890',
          usuario: 'usuario',
        );
        pedido!.hacerPedido();
        pedido!.anadirPedido();
      });

      test('Conseguir pizza de un pedido', () async {
        final response =
            await http.get(Uri.parse('http://localhost:3000/pedidos/77'));
        if (response.statusCode == 200) {
          pedido = Pedido.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load pedido');
        }
      });

      test('Pedido realizado', () {
        expect(pedido!.pedidoRealizado, isTrue);
      });

      test('Comprobar Coste Total', () async {
        var costeTotalEsperado =
            pizza!.getCoste(pizza!.tamano) + pizza2!.getCoste(pizza2!.tamano);
        final response =
            await http.get(Uri.parse('http://localhost:3000/pedidos/77'));
        if (response.statusCode == 200) {
          pedido = Pedido.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load pedido');
        }
        expect(pedido!.getCosteTotal(), costeTotalEsperado);
      });

      test('Pedido elimina las pizzas', () {
        pedido!.clear();
        expect(pedido!.pizzas, isEmpty);
      });
    });

    group('Carta', () {
      Carta? carta;
      const fotoPizza = 'assets/margarita.jpg';

      setUp(() {
        carta = Carta();
        carta!.reset();
        carta!.addPizza(pizza!, fotoPizza);
        carta!.addPizza(pizza2!, fotoPizza);
      });

      test('añade a la carta', () {
        expect(carta!.pizzas[0], isNotNull);
        expect(carta!.pizzas[1], isNotNull);
        expect(carta!.pizzas[0].pizza, equals(pizza!));
        expect(carta!.pizzas[1].pizza, equals(pizza2!));
        expect(carta!.pizzas[1].foto, equals(fotoPizza));
        expect(carta!.pizzas.length, 2);
      });

      test('removePizza elimina una pizza de la carta', () {
        carta!.removePizza(pizza!.getNombre);
        carta!.removePizza(pizza2!.getNombre);
        expect(carta!.pizzas, isNot(contains(pizza!)));
        expect(carta!.pizzas, isNot(contains(pizza2!)));
        expect(carta!.pizzas.length, 0);
      });

      test('reset borra todas las pizzas de la carta', () {
        carta!.reset();
        expect(carta!.pizzas, isEmpty);
      });
    });
  });
}
