import 'package:flutter/material.dart';

class MisPedidos extends StatelessWidget {
  final String currentUser;

  MisPedidos({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Pedidos'),
      ),
      body: Center(
        child: Text('Pedidos de $currentUser'),
      ),
    );
  }
}