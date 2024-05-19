import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MisPedidos extends StatelessWidget {
  final String currentUser;

  MisPedidos({required this.currentUser});

  Future<List<dynamic>> fetchPedidos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/pedidos'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pedidos');
    }
  }

  bool canDelete(String createdAt) {
    DateTime now = DateTime.now();
    DateTime orderTime = DateTime.parse(createdAt);
    Duration difference = now.difference(orderTime);
    return difference.inMinutes <= 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Pedidos'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPedidos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var pedido = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.fastfood, color: Colors.green),
                    title: Text('Pedido ${pedido['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dirección: ${pedido['direccion']}'),
                        Text('Tarjeta: ${pedido['tarjeta']}'),
                        Text('Fecha de creación: ${pedido['created_at']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: canDelete(pedido['created_at']) ? () {
                        // Aquí puedes poner la lógica para eliminar el pedido
                      } : null,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}