import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MisPedidos extends StatefulWidget {
  final String currentUser;

  MisPedidos({required this.currentUser});

  @override
  _MisPedidosState createState() => _MisPedidosState();
}

class _MisPedidosState extends State<MisPedidos> {
  Future<List<dynamic>> fetchPedidos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/pedidos'));

    if (response.statusCode == 200) {
      List<dynamic> pedidos = jsonDecode(response.body);
      return pedidos.where((pedido) => pedido['usuario'] == widget.currentUser).toList();
    } else {
      throw Exception('Failed to load pedidos');
    }
  }

  Future<List<dynamic>> fetchPizzas(int pedidoId) async {
    final response = await http.get(Uri.parse('http://localhost:3000/pizzas'));

    if (response.statusCode == 200) {
      List<dynamic> pizzas = jsonDecode(response.body);
      return pizzas.where((pizza) => pizza['pedido_id'] == pedidoId).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }

  Future<void> deletePedido(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:3000/pedidos/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete pedido');
    }
  }

  bool canDelete(String createdAt) {
    DateTime now = DateTime.now();
    DateTime orderTime = DateTime.parse(createdAt);
    Duration difference = now.difference(orderTime);
    return difference.inMinutes <= 10;
  }

  Widget buildPedidoCard(pedido, pizzaSnapshot) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.green),
            title: Text('Pedido ${pedido['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: buildPedidoDetails(pedido),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: canDelete(pedido['created_at']) ? () async {
                await deletePedido(pedido['id']);
                setState(() {});  // This will trigger a rebuild of the UI
              } : null,
            ),
          ),
          ...pizzaSnapshot.data!.map((pizza) => ListTile(
            title: Text('${pizza['nombre']} (${pizza['tamano']})'),
            subtitle: Text('Coste: ${pizza['coste']}'),
          )).toList(),
        ],
      ),
    );
  }

  Widget buildPedidoDetails(pedido) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dirección: ${pedido['direccion']}'),
        Text('Tarjeta: ${pedido['tarjeta']}'),
        Text('Fecha de creación: ${pedido['created_at']}'),
        Text('Coste Total: ${pedido['costeTotal']}'), // Display total cost
      ],
    );
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
            if (snapshot.data!.isEmpty) {
              return Center(child: Text('No hay ningún pedido para este usuario'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var pedido = snapshot.data![index];
                  return FutureBuilder<List<dynamic>>(
                    future: fetchPizzas(pedido['id']),
                    builder: (context, pizzaSnapshot) {
                      if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (pizzaSnapshot.hasError) {
                        return Text('Error: ${pizzaSnapshot.error}');
                      } else {
                        return buildPedidoCard(pedido, pizzaSnapshot);
                      }
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}