import 'package:flutter/material.dart';
import 'package:peliculas/widgets/card_swipper_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba'),
      ),
      body: _swipperTarjetas(),
    );
  }

  _swipperTarjetas() {
    return CardSwipper(
      peliculas: [1,2,3,4,5],
    );
  }
}
