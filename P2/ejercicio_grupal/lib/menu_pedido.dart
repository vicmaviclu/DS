import 'package:flutter/material.dart';
import 'carta.dart';
import 'pedido.dart';
import 'models/pizza_foto.dart';

class MenuPedido extends StatefulWidget {
  @override
  _MenuPedidoState createState() => _MenuPedidoState();
}

class _MenuPedidoState extends State<MenuPedido> {
  final Carta carta = Carta();
  String? pizzaSeleccionada;
  String? tamanoSeleccionado;
  final direccionControlador = TextEditingController();
  final tarjetaControlador= TextEditingController();
  final telefonoControlador = TextEditingController();
  Pedido? pedido;
  List<String> ingredientesAdicionalesDisponibles = ['Aceitunas', 'Champiñones', 'Pimientos', 'Cebolla', 'Extra queso'];
  List<String> ingredientesAdicionalesSeleccionados = [];

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: const DefaultTextStyle(
        style: TextStyle(fontSize:40, color: Colors.black, fontWeight: FontWeight.bold),
        child: Text('Menú de Pedido'),
      ),
      centerTitle: true,
    );
  }

  Widget buildPizzaLista() {
    return DropdownButton<String>(
      hint: const Text('Selecciona una pizza', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
      value: pizzaSeleccionada,
      onChanged: (String? newValue) {
        setState(() {
          pizzaSeleccionada = newValue;
        });
      },
      items: carta.pizzas.map((PizzaConFoto pizzaConFoto) {
        return DropdownMenuItem<String>(
          value: pizzaConFoto.pizza.nombre,
          child: Text(pizzaConFoto.pizza.nombre, style:const TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
        );
      }).toList(),
    );
  }

  Widget buildPizzaTamanoLista() {
    return DropdownButton<String>(
      hint: const Text('Selecciona un tamaño', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
      value: tamanoSeleccionado,
      onChanged: (String? newValue) {
        setState(() {
          tamanoSeleccionado = newValue;
        });
      },
      items: <String>['Pequeño', 'Mediano', 'Grande', 'Gigante'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
        );
      }).toList(),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:const TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget buildBotonPedido() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: clickBoton,
        child: const Text('Realizar Pedido', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void clickBoton() {
    RegExp regExp = RegExp(r'^[0-9]+$');

    if (pizzaSeleccionada != null && 
        tamanoSeleccionado != null && 
        direccionControlador.text.isNotEmpty && 
        regExp.hasMatch(tarjetaControlador.text) && 
        regExp.hasMatch(telefonoControlador.text)) { 
      crearPedido();
      limpiarTexto();
    } else {
      mensajeError();
    }
  }

  void crearPedido() {
    double coste = carta.getCoste(pizzaSeleccionada!, tamanoSeleccionado!) + ingredientesAdicionalesSeleccionados.length * 0.5;
    pedido = Pedido(
      pizzaSeleccionada: pizzaSeleccionada!,
      tamanoSeleccionado: tamanoSeleccionado!,
      direccion: direccionControlador.text,
      tarjeta: tarjetaControlador.text,
      coste: coste,
      numeroTelefono: telefonoControlador.text,
      ingredientesAdicionalesSeleccionados: ingredientesAdicionalesSeleccionados,
    );

    pedido!.hacerPedido();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Padding(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Text(
              'Confirmación del Pedido',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pedido.toString(),
                style:const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Text(
                'Hora estimada de llegada: ${DateTime.now().add(const Duration(minutes: 30)).toLocal().toString().substring(11, 16)} - ${DateTime.now().add(const Duration(minutes: 45)).toLocal().toString().substring(11, 16)}',
                style:const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  void limpiarTexto() {
    setState(() {
      pizzaSeleccionada = null;
      tamanoSeleccionado = null;
      direccionControlador.clear();
      tarjetaControlador.clear();
      telefonoControlador.clear();
      ingredientesAdicionalesSeleccionados.clear();
    });
  }

  void mensajeError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Error'),
          content: const Text('Por favor, rellena todos los campos antes de realizar el pedido. Asegúrate de que el número de tarjeta y el número de teléfono sean solo números.'),          
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoIngredientes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Selecciona ingredientes adicionales'),
              content: Column(
                children: ingredientesAdicionalesDisponibles.map((ingrediente) {
                  return CheckboxListTile(
                    title: Text(ingrediente),
                    value: ingredientesAdicionalesSeleccionados.contains(ingrediente),
                    onChanged: (bool? valor) {
                      if (valor == true) {
                        ingredientesAdicionalesSeleccionados.add(ingrediente);
                      } else {
                        ingredientesAdicionalesSeleccionados.remove(ingrediente);
                      }
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Container(
          width: 450,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildPizzaLista(),
                buildPizzaTamanoLista(),
                buildTextField('Dirección', direccionControlador),
                buildTextField('Tarjeta de Crédito', tarjetaControlador),
                buildTextField('Número de Teléfono', telefonoControlador),
                ElevatedButton(
                  onPressed: mostrarDialogoIngredientes,
                  child: Text('Añadir ingredientes'),
                ),
                buildBotonPedido(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}