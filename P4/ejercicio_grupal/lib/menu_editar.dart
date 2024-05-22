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
  List<dynamic> pizzaIngredientesExtra = [];

  @override
  void initState() {
    super.initState();
    direccionController = TextEditingController(text: widget.pedido['direccion']);
    telefonoController = TextEditingController(text: widget.pedido['numero_telefono']);
    fetchPizzaIngredientesExtra();
  }

  Future<void> fetchPizzaIngredientesExtra() async {
    for (var pizza in widget.pizzas) {
      final response = await http.get(Uri.parse('http://localhost:3000/pizza_ingredientes_extra/${pizza['id']}'));
      if (response.statusCode == 200) {
        pizzaIngredientesExtra.add(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load pizza ingredientes extra');
      }
    }
    setState(() {});
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Pedido ${widget.pedido['id']} Modo Edición'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: pizzaIngredientesExtra.isEmpty
        ? CircularProgressIndicator() // Show loading indicator while data is loading
        : Column(
            children: [
              ListTile(
                subtitle: buildPedidoDetails(),
              ),
              ...widget.pizzas.asMap().entries.map((entry) => ListTile(
                title: Text('${entry.value['nombre']} (${entry.value['tamano']})', style:const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Coste: ${entry.value['coste']}\nExtras: ${pizzaIngredientesExtra[entry.key].map((ingredienteExtra) => ingredienteExtra['nombre']).join(', ')}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuEditarPizza(pizza: entry.value)),
                        );
                      },
                    ),
                    if (widget.pizzas.length > 1) // Only show delete button if there is more than one pizza
IconButton(
  icon:const Icon(Icons.delete),
  onPressed: () async {
    await deletePizzaIngredientesExtra(entry.value['id']);
    await updatePedidoCoste();
    setState(() {}); // This will trigger a rebuild of the UI
  },
),
                  ],
                ),
              )),
              const SizedBox(height: 20),
ElevatedButton(
  onPressed: () async {
    if (direccionController.text.isNotEmpty && telefonoController.text.isNotEmpty) {
      await updatePedido();
      widget.onConfirm(); 
      Navigator.pop(context, true); // Pass a return value to the previous page
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

  Future<List<dynamic>> fetchPizzaIngredientesExtraById(int pizzaId) async {
    final response = await http.get(Uri.parse('http://localhost:3000/pizza_ingredientes_extra/${pizzaId}'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pizza ingredientes extra');
    }
  }

  Future<void> deletePizzaIngredientesExtra(int pizzaId) async {
    // Fetch all pizzaIngredientesExtra for the current pizza
    List<dynamic> ingredientesExtraToDelete = await fetchPizzaIngredientesExtraById(pizzaId);

    for (var ingredienteExtra in ingredientesExtraToDelete) {
      // Delete each ingredienteExtra
      final response = await http.delete(
        Uri.parse('http://localhost:3000/pizza_ingredientes_extra/${ingredienteExtra['id']}'), // Use ingredienteExtra id here
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete pizza ingredientes extra');
      }
    }

    // Fetch all pizzaIngredientesExtra again to update the list
    await deletePizza(pizzaId);
  }

Future<void> deletePizza(int pizzaId) async {
  final response = await http.delete(
    Uri.parse('http://localhost:3000/pizzas/${pizzaId}'), // Use pizzaId here
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete pizza');
  }

  // Remove the pizza from the list
  setState(() {
    widget.pizzas.removeWhere((pizza) => pizza['id'] == pizzaId);
  });
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

Future<void> updatePedidoCoste() async {
  // Fetch all pizzas for the current pedido
  List<dynamic> pizzas = await fetchPizzas(widget.pedido['id']);

  // Calculate the total cost
  double totalCost = pizzas.fold(0.0, (sum, pizza) => sum + double.parse(pizza['coste'].toString()));

  final response = await http.put(
    Uri.parse('http://localhost:3000/pedidos/${widget.pedido['id']}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'costeTotal': totalCost.toStringAsFixed(2),
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update pedido');
  }

}
}