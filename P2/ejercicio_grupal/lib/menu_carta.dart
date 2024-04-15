import 'package:flutter/material.dart';

class MenuCarta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu//Carta'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns
        padding: EdgeInsets.all(16.0), // Padding around each square
        children: <Widget>[
          // List of squares
          Container(
            color: Colors.red,
            child: Center(
              child: Text('Square 1'),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('Square 2'),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text('Square 3'),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Center(
              child: Text('Square 4'),
            ),
          ),
        ],
      ),
    );
  }
}