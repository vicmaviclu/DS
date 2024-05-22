import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuEditarPizza extends StatefulWidget {
  final Map<String, dynamic> pizza;

  MenuEditarPizza({Key? key, required this.pizza}) : super(key: key);

  @override
  _MenuEditarPizzaState createState() => _MenuEditarPizzaState();
}

class _MenuEditarPizzaState extends State<MenuEditarPizza> {
  final apiUrl = 'http://localhost:3000';
  List<String> ingredientesAdicionalesDisponibles = [
    'Aceitunas Extra',
    'Champiñones Extra',
    'Pimientos Extra',
    'Cebolla Extra',
    'queso extra'
  ];

  Map<String, bool> ingredientesSeleccionados = {};

  @override
  void initState() {
    super.initState();
    IngredientesSeleccionados();
    conseguirIngredeintesExtra();
  }

  void IngredientesSeleccionados() {
    ingredientesAdicionalesDisponibles.forEach((ingrediente) {
      ingredientesSeleccionados[ingrediente] = false;
    });
  }

  Future<void> conseguirIngredeintesExtra() async {
    final response = await http.get(Uri.parse('$apiUrl/pizza_ingredientes_extra/${widget.pizza['id']}'));
    if (response.statusCode == 200) {
      List<dynamic> ingredientesExtra = jsonDecode(response.body);
      updateIngredientesSeleccionados(ingredientesExtra);
    } else {
      throw Exception('Failed to load pizza ingredientes extra');
    }
  }

  void updateIngredientesSeleccionados(List<dynamic> ingredientesExtra) {
    setState(() {
      ingredientesAdicionalesDisponibles.forEach((ingrediente) {
        ingredientesSeleccionados[ingrediente] = ingredientesExtra.any((i) => i['nombre'] == ingrediente);
      });
    });
  }

  Future<void> anadirIngredienteExtra(int pizzaId, String ingredienteExtra) async {
    final response = await http.post(
      Uri.parse('$apiUrl/pizza_ingredientes_extra'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'pizza_ingrediente_extra': {
          'nombre': ingredienteExtra, 
          'pizza_id': pizzaId
        }
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add extra ingredient: ${response.body}');
    }
  }

  Future<List<dynamic>> conseguirIngredientesExtraByPizzaId(int pizzaId) async {
    final response = await http.get(Uri.parse('$apiUrl/pizza_ingredientes_extra/${pizzaId}'));
  
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pizza ingredientes extra');
    }
  }

  Future<void> deletePizzaIngredientesExtra(int pizzaId, String ingredienteExtra) async {
    List<dynamic> ingredientesExtraToDelete = await conseguirIngredientesExtraByPizzaId(pizzaId);

    for (var ingrediente in ingredientesExtraToDelete) {
      if (ingrediente['nombre'] == ingredienteExtra) {
        final response = await http.delete(
          Uri.parse('$apiUrl/pizza_ingredientes_extra/${ingrediente['id']}'),
        );

        if (response.statusCode != 200) {
          throw Exception('Failed to delete pizza ingredientes extra');
        }
      }
    }
  }

  Future<void> handleConfirm() async {
    for (var ingrediente in ingredientesSeleccionados.entries) {
      if (ingrediente.value) {
        List<dynamic> ingredientesExtra = await conseguirIngredientesExtraByPizzaId(widget.pizza['id']);
        bool ingredienteExists = ingredientesExtra.any((i) => i['nombre'] == ingrediente.key);
        if (!ingredienteExists) {
          await anadirIngredienteExtra(widget.pizza['id'], ingrediente.key);
        }
      } else {
        await deletePizzaIngredientesExtra(widget.pizza['id'], ingrediente.key);
      }
    }
  }

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
            Text('Nombre: ${widget.pizza['nombre']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Tamaño: ${widget.pizza['tamano']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Coste: ${widget.pizza['coste']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            ...ingredientesSeleccionados.keys.map((ingrediente) {
              return CheckboxListTile(
                title: Text(ingrediente),
                value: ingredientesSeleccionados[ingrediente],
                onChanged: (bool? value) {
                  setState(() {
                    ingredientesSeleccionados[ingrediente] = value!;
                  });
                },
              );
            }).toList(),
            ElevatedButton(
              onPressed: () async {
                await handleConfirm();
                Navigator.pop(context, true); 
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}