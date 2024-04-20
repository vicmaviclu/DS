class SistemaEnvios {
  final String direccion;

  SistemaEnvios({required this.direccion});

  void enviarPedido() {
    print('Enviando el pedido a la dirección $direccion');
  }
}