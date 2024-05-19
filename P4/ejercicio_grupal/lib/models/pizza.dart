class Pizza {
  int ?id;
  int ?pedido_id;
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

  Pizza();

  // Getters
  String get getNombre => nombre;
  double get getPrecio => precio;
  List<String> get getIngredientes => ingredientes;
  String get getTamano => tamano;

  set setNombre(String nuevoNombre) {
    nombre = nuevoNombre;
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

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza()
      ..id = json['id'] as int?
      ..nombre = json['nombre'] as String? ?? 'Pizza '
      ..precio = (json['coste'] as num?)?.toDouble() ?? 0.0
      ..tamano = json['tamano'] as String? ?? ''
      ..pedido_id = json['pedido_id'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'coste': precio,
      'tamano': tamano,
      if (pedido_id != null) 'pedido_id': pedido_id,
    };
  }
}