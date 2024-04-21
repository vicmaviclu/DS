import '../pizza_factory.dart';
import '/models/pizza.dart';
import '../pizza_extras.dart';

import 'sistema_envios.dart';
import 'sistema_pagos.dart';

class Pedido {
  Pizza? pizza;
  static int _contadorPedidos = 0;
  final int numeroPedido;
  final String pizzaSeleccionada;
  final String tamanoSeleccionado;
  final SistemaEnvios sistemaEnvios;
  SistemaPagos sistemaPagos;
  final String numeroTelefono;
  List<String> ingredientesAdicionalesSeleccionados = [];

  Pedido({
    required this.pizzaSeleccionada,
    required this.tamanoSeleccionado,
    required String direccion,
    required String tarjeta,
    required this.numeroTelefono,
    required this.ingredientesAdicionalesSeleccionados,
  })  : sistemaEnvios =
            SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta),
        numeroPedido = ++_contadorPedidos;

  void hacerPedido() {
    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    pizza = PizzaFactory.createPizza(pizzaSeleccionada, tamanoSeleccionado);
    if (ingredientesAdicionalesSeleccionados.isNotEmpty) {
      PizzaExtras.anadirExtras(pizza!, ingredientesAdicionalesSeleccionados);
    }
    sistemaPagos.coste = pizza!.getCoste(tamanoSeleccionado);
    print('Pedido realizado');
  }

  @override
  String toString() {
    return '\n'
        'Número de pedido: $numeroPedido\n'
        'Pizza seleccionada: $pizzaSeleccionada\n'
        'Tamaño seleccionado: $tamanoSeleccionado\n'
        'Dirección: ${sistemaEnvios.direccion}\n'
        'Número de teléfono: $numeroTelefono\n'
        'Tarjeta: ${sistemaPagos.tarjeta}\n'
        'Coste: ${sistemaPagos.coste}\n'
        'Extras: ${ingredientesAdicionalesSeleccionados.isEmpty ? 'No extras' : ingredientesAdicionalesSeleccionados.join(', ')}';
  }
}
