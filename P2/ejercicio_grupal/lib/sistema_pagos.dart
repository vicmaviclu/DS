class SistemaPagos {
  final String tarjeta;
  final double coste;

  SistemaPagos({required this.tarjeta, required this.coste});

  void procesarPago() {
    print('Procesando el pago con la tarjeta $tarjeta');
  }
}