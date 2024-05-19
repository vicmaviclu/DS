import '/models/pizza.dart';
import 'sistema_envios.dart';
import 'sistema_pagos.dart';

// Clase pedido actua como una fachada
class Pedido {
  int ?id;
  List<Pizza> pizzas = [];
  final SistemaEnvios sistemaEnvios;
  SistemaPagos sistemaPagos;
  final String numeroTelefono;
  bool _pedidoRealizado = false;

  Pedido({
    required this.pizzas,
    required String direccion,
    required String tarjeta,
    required this.numeroTelefono,
  })  : sistemaEnvios =
            SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta);

  String get direccion => sistemaEnvios.direccion;
  String get tarjeta => sistemaPagos.tarjeta;
  bool get pedidoRealizado => _pedidoRealizado;

  void hacerPedido() {
    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    double totalCost = 0;
    for (var pizza in pizzas) {
      totalCost += pizza.getCoste(pizza.tamano);
    }
    sistemaPagos.coste = (totalCost);
    _pedidoRealizado = true;
    // print('Pedido realizado');
  }

  @override
  String toString() {
    String pedido = 'Número de pedido: ${id}\n';
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

  void clear() {
    pizzas.clear();
  }

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      pizzas: (json['pizzas'] as List<dynamic>?)
              ?.map((e) => Pizza.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      direccion: json['direccion'] as String? ?? '',
      tarjeta: json['tarjeta'] as String? ?? '',
      numeroTelefono: json['numero_telefono'] as String? ?? '',
    )
      ..id = json['id'] as int?
      .._pedidoRealizado = json['pedido_realizado'] as bool? ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'numero_pedido': id,
      'numero_telefono': numeroTelefono,
      'pedido_realizado': _pedidoRealizado,
      'direccion': direccion,
      'tarjeta': tarjeta,
      'pizzas': pizzas.map((e) => e.toJson()).toList(),
    };
  }
}