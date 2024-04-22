import '../factory/pizza_factory.dart';
import '/models/pizza.dart';
import 'pizza_extras.dart';

import 'sistema_envios.dart';
import 'sistema_pagos.dart';

// Clase pedido actua como una fachada
class Pedido {
  List<Pizza> pizzas = [];
  static int _contadorPedidos = 0;
  final int numeroPedido;
  final SistemaEnvios sistemaEnvios;
  SistemaPagos sistemaPagos;
  final String numeroTelefono;

  Pedido({
    required this.pizzas,
    required String direccion,
    required String tarjeta,
    required this.numeroTelefono,
  })  : sistemaEnvios =
            SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta),
        numeroPedido = ++_contadorPedidos;

  String get direccion => sistemaEnvios.direccion;
  String get tarjeta => sistemaPagos.tarjeta;
  
  void hacerPedido() {
    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    double totalCost = 0;
    for (var pizza in pizzas) {
      totalCost += pizza.getCoste(pizza.tamano);
    }
    sistemaPagos.coste = (totalCost);
    print('Pedido realizado');
  }

  @override
  String toString() {
    String pedido = 'Número de pedido: $numeroPedido\n';
    for (var pizza in pizzas) {
      pedido += pizza.toString() + '\n';
    }
    return pedido;
  }

  double getCosteTotal() {
    double totalCost = 0;
    for (var pizza in pizzas) {
      totalCost += pizza.getCoste(pizza.tamano);
    }
    return totalCost;
  }

  void clear(){
    pizzas.clear();
  }
}