import 'package:flutter/material.dart';
import 'models/carta.dart';
import 'models/pizza_foto.dart';

class MenuCarta extends StatelessWidget {
  final Carta carta = Carta();

  Widget buildCarta(PizzaConFoto pizzaConFoto) {
    return Column(
      children: [
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 220.0,
              height: 200.0,
              child: Image.asset(
                pizzaConFoto.foto,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Text(
                pizzaConFoto.pizza.nombre,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '${pizzaConFoto.pizza.precio} €',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Center(
          child: Text(
            pizzaConFoto.pizza.ingredientes.join(', '),
            textAlign: TextAlign.center, // Centra el texto en el centro
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DefaultTextStyle(
          style: TextStyle(
              fontSize: 40, color: Colors.purple, fontWeight: FontWeight.bold),
          child: Text('Carta de pizzas'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 450,
          color: Colors.purple,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            children: List.generate(carta.pizzas.length, (index) {
              return Card(
                child: buildCarta(carta.pizzas[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
