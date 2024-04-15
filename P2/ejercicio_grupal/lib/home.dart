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
              Image.asset(
                'images/descarga.png',
                fit: BoxFit.cover,
                height: 100,
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bandera.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  'Pizzería Casalini',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 237, 12, 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: 300,
          child: ListView(
            children: [
              MyExpansionPanel(
                title: 'Pizza Margherita',
                children: ['Tomate', 'Mozzarella', 'Albahaca'],
              ),
              MyExpansionPanel(
                title: 'Pizza Pepperoni',
                children: ['Tomate', 'Mozzarella', 'Pepperoni'],
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

  const MyExpansionPanel(
      {Key? key, required this.title, required this.children})
      : super(key: key);

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
          _isExpanded = !_isExpanded;
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
            children: widget.children
                .map((String ingredient) => ListTile(title: Text(ingredient)))
                .toList(),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
