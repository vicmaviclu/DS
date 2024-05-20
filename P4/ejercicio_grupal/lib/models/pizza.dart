import 'dart:convert';
import 'package:http/http.dart' as http;

class Pizza {
  int? id;
  int? pedido_id;
  String nombre = 'Pizza ';
  double precio = 0.0;
  List<String> ingredientes = [];
  List<String> ingredientesAdicionales = [];
  String tamano = '';
  Map<String, double> costesAdicionales = {
    'Mediana': 1.0,
    'Grande': 2.0,
    'Gigante': 3.0,
  };

  Pizza({this.id, this.pedido_id, this.nombre = 'Pizza ', this.tamano = '', this.precio = 0.0});

  // Getters
  String get getNombre => nombre;
  double get getPrecio => precio;
  List<String> get getIngredientes => ingredientes;
  String get getTamano => tamano;
  List<String> get getIngredientesAdicionales => ingredientesAdicionales;

  Future<void> anadirPizza(String apiUrl) async {
    final response = await http.post(
      Uri.parse('$apiUrl/pizzas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(this.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save pizza: ${response.body}');
    }
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // Comenta o elimina esta línea
      'pedido_id': pedido_id,
      'nombre': nombre,
      'tamano': tamano,
      'coste': precio,
      // Resto de los campos de la pizza...
    };
  }

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      pedido_id: json['pedido_id'],
      nombre: json['nombre'] ?? '',
      tamano: json['tamano'] ?? '',
      precio: json['coste'] ?? 0.0,
    );
  }
  set setNombre(String nuevoNombre) {
    nombre += nuevoNombre;
  }

  set setPrecio(double nuevoPrecio) {
    precio = nuevoPrecio;
  }

  set setIngredientes(List<String> nuevosIngredientes) {
    ingredientes = nuevosIngredientes;
  }

  set setTamano(String nuevoTamano) {
    tamano = nuevoTamano;
  }

  void updatePrecio(double incremento) {
    precio += incremento;
  }

  void addIngrediente(String nuevoIngrediente) {
    ingredientesAdicionales.add(nuevoIngrediente);
  }

  double getCoste(String tamano) {
      double costeAdicional = costesAdicionales[tamano] ?? 0.0;
      return getPrecio + costeAdicional;
  }
  @override
  String toString() {
    return 'Pizza $nombre'' T: $tamano \n'
        'Ingredientes: ${ingredientes.join(', ')}\n'
        'Extras: ${ingredientesAdicionales.isEmpty ? 'No extras' : ingredientesAdicionales.join(', ')}\n'
        'Precio: ${getCoste(tamano)}\n'; 
  }
}