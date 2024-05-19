import '/models/pizza.dart';
import 'sistema_envios.dart';
import 'sistema_pagos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Clase pedido actua como una fachada
class Pedido {
  final apiUrl = 'http://localhost:3000';
  final String usuario;
  List<Pizza> pizzas = [];
  static int _contadorPedidos = 0;
  int? numeroPedido;
  final SistemaEnvios sistemaEnvios;
  SistemaPagos sistemaPagos;
  final String numeroTelefono;
  bool _pedidoRealizado = false;

  Pedido({
    required this.pizzas,
    required String direccion,
    required String tarjeta,
    required this.numeroTelefono,
    required this.usuario,
    int? numeroPedido,
  })  : sistemaEnvios =
          SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta) {
    this.numeroPedido = numeroPedido ?? ++_contadorPedidos;
  }

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
    anadirPedido();
  }

  Future<void> anadirPedido() async {
    final response = await http.post(
      Uri.parse('$apiUrl/pedidos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': numeroPedido,
        'numeroTelefono': numeroTelefono,
        'direccion': direccion,
        'tarjeta': tarjeta,
        'usuario': usuario,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to save order: ${response.body}');
    }
  }

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      numeroTelefono: json['numero_telefono'],
      direccion: json['direccion'],
      tarjeta: json['tarjeta'],
      usuario: json['usuario'],
      pizzas: [], // Aquí necesitas proporcionar una lista de pizzas. Asegúrate de ajustar esto según tus necesidades.
      numeroPedido: json['id'],
    );
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

  void clear() {
    pizzas.clear();
  }
}