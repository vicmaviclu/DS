import 'sistema_envios.dart';
import 'sistema_pagos.dart';

class Pedido {
  static int _contadorPedidos = 0; // Variable de clase para llevar la cuenta de los pedidos
  final int numeroPedido; // Variable de instancia para el número de este pedido
  final String pizzaSeleccionada;
  final String tamanoSeleccionado;
  final SistemaEnvios sistemaEnvios;
  final SistemaPagos sistemaPagos;
  final String numeroTelefono; // Nueva variable de instancia

  Pedido({
    required this.pizzaSeleccionada,
    required this.tamanoSeleccionado,
    required String direccion,
    required String tarjeta,
    required double coste,
    required this.numeroTelefono, // Actualiza el constructor
  })  : sistemaEnvios = SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono), // Actualiza la creación de la instancia de SistemaEnvios
        sistemaPagos = SistemaPagos(tarjeta: tarjeta, coste: coste),
        numeroPedido = ++_contadorPedidos; // Incrementa el contador y asigna el valor a numeroPedido

  void hacerPedido() {
    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    print('pedido realizado');
  }

  @override
  String toString() {
    return '\n'
           'Número de pedido: $numeroPedido\n' // Añade el número de pedido a la salida
           'Pizza seleccionada: $pizzaSeleccionada\n'
           'Tamaño seleccionado: $tamanoSeleccionado\n'
           'Dirección: ${sistemaEnvios.direccion}\n'
           'Número de teléfono: $numeroTelefono\n' // Añade el número de teléfono a la salida
           'Tarjeta: ${sistemaPagos.tarjeta}\n'
           'Coste: ${sistemaPagos.coste}';
  }
}