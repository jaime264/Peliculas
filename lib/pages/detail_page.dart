import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class DetailPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

  Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(child: Text('titulo ${pelicula.title}'),),
    );
  }
}