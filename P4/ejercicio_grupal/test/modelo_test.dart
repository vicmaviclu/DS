import 'package:ejercicio_grupal/builders/director.dart';
import 'package:ejercicio_grupal/builders/margarita_builder.dart';
import 'package:ejercicio_grupal/decorator/pizza_adicional_queso.dart';
import 'package:ejercicio_grupal/factory/pizza_factory.dart';
import 'package:ejercicio_grupal/models/pizza_extras.dart';
import 'package:ejercicio_grupal/models/pizza_foto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ejercicio_grupal/models/pizza.dart';
import 'package:ejercicio_grupal/models/pedido.dart';
import 'package:ejercicio_grupal/models/carta.dart';

void main() {
  group("Comprobacion pizzas", () {
    Pizza? pizza;
    const nombre = 'Pizza Margarita';
    const tamano = 'Mediana';
    const precio = 8.5;
    const ingredientes = ['Tomate', 'Mozzarella', 'Albahaca'];

    setUp(() {
      pizza = Pizza();
    });

    void checkPizza(Pizza pizza, String nombre, double precio,
        List<String> ingredientes, String tamano) {
      expect(pizza.getNombre, nombre);
      expect(pizza.getPrecio, precio);
      expect(pizza.getIngredientes, ingredientes);
      expect(pizza.getTamano, tamano);
    }

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

      PizzaExtras.anadirExtras(pizza!, ['Extra queso']);

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
      PizzaExtras.anadirExtras(pizza!, ['Extra queso']);
    });

    group('Realizar Pedido', () {
      Pedido? pedido;

      setUp(() {
        pedido = Pedido(
          pizzas: [pizza!, pizza2!],
          direccion: '123 Calle Falsa',
          tarjeta: '1234567812345678',
          numeroTelefono: '1234567890',
        );
        pedido!.hacerPedido();
      });

      test('Pedido realizado', () {
        expect(pedido!.pedidoRealizado, isTrue);
      });

      test('Comprobar Coste Total', () {
        var costeTotalEsperado =
            pizza!.getCoste(pizza!.tamano) + pizza2!.getCoste(pizza2!.tamano);
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
