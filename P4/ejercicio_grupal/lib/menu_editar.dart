import 'package:ejercicio_grupal/menu_editar_pizza.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoEditar extends StatefulWidget {
  final dynamic pedido;
  final List<dynamic> pizzas;
  final VoidCallback onConfirm;

  const PedidoEditar({required this.pedido, required this.pizzas, required this.onConfirm});

  @override
  _PedidoEditarState createState() => _PedidoEditarState();
}

class _PedidoEditarState extends State<PedidoEditar> {
  late TextEditingController direccionController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    direccionController = TextEditingController(text: widget.pedido['direccion']);
    telefonoController = TextEditingController(text: widget.pedido['numero_telefono']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${widget.pedido['id']} Modo Edición'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              subtitle: buildPedidoDetails(),
            ),
            ...widget.pizzas.map((pizza) => ListTile(
              title: Text('${pizza['nombre']} (${pizza['tamano']})', style:const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Coste: ${pizza['coste']}'),
              trailing: IconButton(
                icon:const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuEditarPizza(pizza: pizza)),
                  );
                },
              ),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (direccionController.text.isNotEmpty && telefonoController.text.isNotEmpty) {
                  await updatePedido();
                  widget.onConfirm(); 
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La dirección y el teléfono no pueden estar vacíos'),
                    ),
                  );                
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              child:const Text('Confirmar')
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPedidoDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: direccionController,
          decoration:const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Dirección',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: telefonoController,
          decoration:const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Teléfono',
          ),
        ),
        const SizedBox(height: 10),
        Text('Tarjeta: ${widget.pedido['tarjeta']}', style:const TextStyle(fontWeight: FontWeight.bold)),
        Text('Coste Total: ${widget.pedido['costeTotal']}', style:const TextStyle(fontWeight: FontWeight.bold)), // Display total cost
      ],
    );
  }

  Future<void> updatePedido() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/pedidos/${widget.pedido['id']}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'direccion': direccionController.text,
        'numero_telefono': telefonoController.text,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pedido');
    }
  }
}