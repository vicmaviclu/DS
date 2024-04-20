import 'package:flutter/material.dart';
import 'carta.dart';
import 'pedido.dart';

class MenuPedido extends StatefulWidget {
  @override
  _MenuPedidoState createState() => _MenuPedidoState();
}

class _MenuPedidoState extends State<MenuPedido> {
  final Carta carta = Carta();
  String? pizzaSeleccionada;
  String? tamanoSeleccionado;
  final direccionController = TextEditingController();
  final tarjetaController = TextEditingController();
  Pedido? pedido;

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: const DefaultTextStyle(
        style: TextStyle(fontSize:40, color: Colors.black, fontWeight: FontWeight.bold),
        child: Text('Menú de Pedido'),
      ),
      centerTitle: true,
    );
  }

  Widget buildPizzaDropdown() {
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
          child: Text(pizzaConFoto.pizza.nombre, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
        );
      }).toList(),
    );
  }

  Widget buildSizeDropdown() {
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
          child: Text(value, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
        );
      }).toList(),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

Widget buildOrderButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () {
        if (pizzaSeleccionada != null && tamanoSeleccionado != null && direccionController.text.isNotEmpty && tarjetaController.text.isNotEmpty) {
          double coste = carta.getCoste(pizzaSeleccionada!, tamanoSeleccionado!);
          pedido = Pedido(
            pizzaSeleccionada: pizzaSeleccionada!,
            tamanoSeleccionado: tamanoSeleccionado!,
            direccion: direccionController.text,
            tarjeta: tarjetaController.text,
            coste: coste,
          );

          pedido!.hacerPedido();

showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 2.0), // Reduce el padding inferior
        child: Text(
          'Confirmación del Pedido',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
        children: <Widget>[
          Text(
            pedido.toString(),
            style: TextStyle(fontSize: 18), // Aumenta el tamaño de la fuente a 18
          ),          
          const SizedBox(height: 30),
          Text(
            'Hora estimada de llegada: ${DateTime.now().add(const Duration(minutes: 30)).toLocal().toString().substring(11, 16)} - ${DateTime.now().add(Duration(minutes: 45)).toLocal().toString().substring(11, 16)}',
            style:const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  },
);

          // Limpiar los campos
          setState(() {
            pizzaSeleccionada = null;
            tamanoSeleccionado = null;
            direccionController.clear();
            tarjetaController.clear();
          });
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:const Text('Error'),
                content: const Text('Por favor, rellena todos los campos antes de realizar el pedido.'),
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
      },
      child: const Text('Realizar Pedido', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
    ),
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
                buildPizzaDropdown(),
                buildSizeDropdown(),
                buildTextField('Dirección', direccionController),
                buildTextField('Tarjeta de Crédito', tarjetaController),
                buildOrderButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}