import 'package:ejercicio_grupal/menu_editar.dart';
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

  Future<void> deletePizzas(int pedidoId) async {
    final pizzas = await fetchPizzas(pedidoId);
    for (var pizza in pizzas) {
      final response = await http.delete(Uri.parse('http://localhost:3000/pizzas/${pizza['id']}'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete pizza');
      }
    }
  }

  Future<void> deletePedido(int id) async {
    await deletePizzas(id);
    final response = await http.delete(Uri.parse('http://localhost:3000/pedidos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pedido');
    }
  }

  // Puede editaar/eliminar si han pasado menos de 10 min
  bool canEE(String createdAt) {
    DateTime now = DateTime.now();
    DateTime orderTime = DateTime.parse(createdAt);
    Duration difference = now.difference(orderTime);
    return difference.inMinutes <= 10;
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

  Future<List<dynamic>> fetchPedidosWithPizzas() async {
    final response = await http.get(Uri.parse('http://localhost:3000/pedidos'));

    if (response.statusCode == 200) {
      List<dynamic> pedidos = jsonDecode(response.body);
      pedidos = pedidos.where((pedido) => pedido['usuario'] == widget.currentUser).toList();

      for (var pedido in pedidos) {
        pedido['pizzas'] = await fetchPizzas(pedido['id']);
        pedido['numero_pedido'] = pedido['id']; // Add this line
      }

      return pedidos;
    } else {
      throw Exception('Failed to load pedidos');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title:const Text('Mis Pedidos'),
    ),
    body: FutureBuilder<List<dynamic>>(
      future: fetchPedidosWithPizzas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay ningún pedido para este usuario'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var pedido = snapshot.data![index];
                return buildPedidoCard(pedido, pedido['pizzas']);
              },
            );
          }
        }
      },
    ),
  );
}

Widget buildPedidoCard(pedido, pizzas) {
  return Card(
    margin:const EdgeInsets.all(8.0),
    child: Column(
      children: [
        ListTile(
          leading:const Icon(Icons.shopping_cart, color: Colors.green),
          title: Text('Pedido ${pedido['id']}', style:const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: buildPedidoDetails(pedido),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon:const Icon(Icons.edit, color: Colors.blue),
                onPressed: canEE(pedido['created_at']) ? () async {
                  if (mounted) { // Check if the widget is still mounted
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PedidoEditar(pedido: pedido, pizzas: pizzas, onConfirm: (){setState(() {});},)),
                    );
                  }
                } : null,
              ),
              IconButton(
                icon:const Icon(Icons.delete, color: Colors.red),
                onPressed: canEE(pedido['created_at']) ? () async {
                  await deletePedido(pedido['id']);
                  setState(() {});  
                } : null,
              ),
            ],
          ),
        ),
        ...pizzas.map((pizza) => ListTile(
          title: Text('${pizza['nombre']} (${pizza['tamano']})'),
          subtitle: Text('Coste: ${pizza['coste']}'),
        )).toList(),
      ],
    ),
  );
}
}