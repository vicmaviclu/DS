import 'package:ejercicio_grupal/menu_carta.dart';
import 'package:flutter/material.dart';
import 'menu_pedido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Pizzeria Casalini'), 
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTitulo(),
      body: buildCuerpo(),
    );
  }

  AppBar buildTitulo() {
    return AppBar(
      title: Center(
        child: Text(          
          widget.title,
          style: const TextStyle(
            color: Colors.purple, 
            fontSize: 50.0, 
            fontWeight: FontWeight.bold,
            ),
        )
      ),
    );
  }

  // Construye un botón con el texto dado
  Widget buildBoton(String texto) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 200.0,
        height: 50.0,
        child: ElevatedButton(
          onPressed: () { 
            if(texto == 'Carta')  {       
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuCarta()),
            );
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPedido()),
              );
            }
          },
          child: Center(
            child: Text(
              texto,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
  
  // Construye los botones
  Widget buildBotones() {
    return Column(
      children: <Widget>[
        buildBoton('Carta'),
        buildBoton('Hacer pedido'),
      ],
    );
  }

  Center buildCuerpo() {
    return Center(
      child: Container(
        color: Colors.grey[200],
        width: 350, // Tamaño movil mas o menos
        height: 800,
        child: Column(
          children: <Widget>[
          Image.asset('assets/logo.jpeg'), 
          buildBotones(),
          ],
        ),
      ),
    );
  }
}
