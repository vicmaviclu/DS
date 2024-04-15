import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('images/descarga.png', fit: BoxFit.cover, height: 30,), // Reemplaza 'assets/image.png' con la ruta de tu imagen
              SizedBox(width: 10), // Añade un espacio entre la imagen y el texto
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bandera.png'), // Reemplaza 'images/fondo.png' con la ruta de tu imagen de fondo
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  'Pizzería Casalini',
                  style: TextStyle(
                    fontSize: 44, // Cambia el tamaño del texto
                    fontWeight: FontWeight.bold, // Hace el texto en negrita
                    color: const Color.fromARGB(255, 237, 12, 12), // Cambia el color del texto
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}