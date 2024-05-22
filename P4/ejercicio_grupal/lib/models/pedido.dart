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
  double? costeTotal;

  Pedido({
    required this.pizzas,
    required String direccion,
    required String tarjeta,
    required this.numeroTelefono,
    required this.usuario,
    int? numeroPedido,
    this.costeTotal,
  })  : sistemaEnvios = SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta) {
    this.numeroPedido = numeroPedido ?? ++_contadorPedidos;
  }

  String get direccion => sistemaEnvios.direccion;
  String get tarjeta => sistemaPagos.tarjeta;
  bool get pedidoRealizado => _pedidoRealizado;

  Future<void> hacerPedido() async {
    await anadirPedido(); 

    double totalCost = 0;
    for (var pizza in pizzas) {
      pizza.pedido_id = this.numeroPedido;
      totalCost += pizza.getCoste(pizza.tamano);
      await pizza.anadirPizza(apiUrl); 
    }

    this.costeTotal = totalCost;
    await actualizarCosteTotalPedido(apiUrl, this.numeroPedido, totalCost);

    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    sistemaPagos.coste = (totalCost);
    _pedidoRealizado = true;
  }

  Future<void> anadirPedido() async {
    final response = await http.post(
      Uri.parse('$apiUrl/pedidos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(this.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save order: ${response.body}');
    }

    this.numeroPedido = jsonDecode(response.body)['id']; 
  }

  Future<void> actualizarCosteTotalPedido(String apiUrl, int? numeroPedido, double totalCost) async {
    final response = await http.put(
      Uri.parse('$apiUrl/pedidos/$numeroPedido'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'costeTotal': totalCost}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order cost: ${response.body}');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': numeroPedido,
      'numero_telefono': numeroTelefono,
      'direccion': direccion,
      'tarjeta': tarjeta,
      'usuario': usuario,
      'costeTotal': costeTotal,
    };
  }

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      numeroTelefono: json['numero_telefono'],
      direccion: json['direccion'],
      tarjeta: json['tarjeta'],
      usuario: json['usuario'],
      pizzas: [], 
      numeroPedido: json['id'],
      costeTotal: json['costeTotal'],
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