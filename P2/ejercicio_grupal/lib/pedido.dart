import 'sistema_envios.dart';
import 'sistema_pagos.dart';

class Pedido {
  final String pizzaSeleccionada;
  final String tamanoSeleccionado;
  final SistemaEnvios sistemaEnvios;
  final SistemaPagos sistemaPagos;

  Pedido({
    required this.pizzaSeleccionada,
    required this.tamanoSeleccionado,
    required String direccion,
    required String tarjeta,
    required double coste,
  })  : sistemaEnvios = SistemaEnvios(direccion: direccion),
        sistemaPagos = SistemaPagos(tarjeta: tarjeta, coste: coste);

  void hacerPedido() {
    sistemaPagos.procesarPago();
    sistemaEnvios.enviarPedido();
    // LLamar al builder correspondiente para hacer la pizza y devolverla
    // Se puede hacer un controlador de builders que llame al builder correspondiente
    // o hacer unos builders que te hagan la pizza basica con cada tamaño
    // y luego hacer el patron decorador para los ingedientes(decoradorPepperoni, decoradorMargarita, etc)
    print('pedido realizado');
  }

  @override
  String toString() {
    return '\n'
           'Pizza seleccionada: $pizzaSeleccionada\n'
           'Tamaño seleccionado: $tamanoSeleccionado\n'
           'Dirección: ${sistemaEnvios.direccion}\n'
           'Tarjeta: ${sistemaPagos.tarjeta}\n'
           'Coste: ${sistemaPagos.coste}';
  }
}