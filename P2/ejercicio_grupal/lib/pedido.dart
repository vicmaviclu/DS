class SistemaEnvios {
  final String direccion;

  SistemaEnvios({required this.direccion});

  void enviarPedido() {
    print('Enviando el pedido a la dirección $direccion');
  }
}

class SistemaPagos {
  final String tarjeta;
  final double coste;

  SistemaPagos({required this.tarjeta, required this.coste});

  void procesarPago() {
    print('Procesando el pago con la tarjeta $tarjeta');
  }
}

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