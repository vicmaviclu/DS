import 'sistema_envios.dart';
import 'sistema_pagos.dart';

class Pedido {
  static int _contadorPedidos = 0; 
  final int numeroPedido; 
  final String pizzaSeleccionada;
  final String tamanoSeleccionado;
  final SistemaEnvios sistemaEnvios;
  final SistemaPagos sistemaPagos;
  final String numeroTelefono; 

  Pedido({
    required this.pizzaSeleccionada,
    required this.tamanoSeleccionado,
    required String direccion,
    required String tarjeta,
    required double coste,
    required this.numeroTelefono, 
  })  : sistemaEnvios = SistemaEnvios(direccion: direccion, numeroTelefono: numeroTelefono),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta, coste: coste),
        numeroPedido = ++_contadorPedidos;

  void hacerPedido() {
    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    print('pedido realizado');
    // LLamar al builder correspondiente para hacer la pizza y devolverla
    // Se puede hacer un controlador de builders que llame al builder correspondiente
    // o hacer unos builders que te hagan la pizza basica con cada tamaño
    // y luego hacer el patron decorador para los ingedientes(decoradorPepperoni, decoradorMargarita, etc)
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
           'Coste: ${sistemaPagos.coste}';
  }
}