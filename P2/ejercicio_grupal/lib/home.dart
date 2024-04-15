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
              Image.asset('assets/images/descarga.png', fit: BoxFit.cover, height: 100,), // Reemplaza 'assets/image.png' con la ruta de tu imagen
              SizedBox(width: 10), // Añade un espacio entre la imagen y el texto
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bandera.jpg'), // Reemplaza 'images/bandera.jpg' con la ruta de tu imagen de fondo
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
      ),
    );
  }
}

class MyExpansionPanel extends StatefulWidget {
  final String title;
  final List<String> children;

  const MyExpansionPanel({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  _MyExpansionPanelState createState() => _MyExpansionPanelState();
}

class _MyExpansionPanelState extends State<MyExpansionPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(widget.title),
            );
          },
          body: Column(
            children: widget.children.map((String ingredient) => ListTile(title: Text(ingredient))).toList(),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}