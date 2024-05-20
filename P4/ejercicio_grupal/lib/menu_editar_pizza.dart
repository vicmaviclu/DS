import 'package:ejercicio_grupal/menu_editar_pizza.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuEditarPizza extends StatelessWidget {
  final Map<String, dynamic> pizza;

  MenuEditarPizza({Key? key, required this.pizza}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Pizza'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nombre: ${pizza['nombre']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Tamaño: ${pizza['tamano']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Coste: ${pizza['coste']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}