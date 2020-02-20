import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  final peliculas = new PeliculasProvider();

  String seleccion = '';

  final pelicula = [
    'Spiderman',
    'Venom',
    'Acquaman',
    'Batman',
    'Shazam',
    'Iroman',
    'Capitan America',
    'Superman'
  ];

  final peliculaReciente = ['Spiderman', 'Iroman'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculas.buscarPelicula(query),
      builder: (BuildContext context , AsyncSnapshot<List<Pelicula>> snapshot){

        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((p){
              return ListTile(
                title: Text(p.title),
                subtitle: Text(p.originalTitle??''),
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(p.getPosterPath()),
                  width: 50,
                  ),
                  onTap: (){
                    p.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: p);
                  },
              );
            }).toList(),

          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }

      }
      );


  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // TODO: implement buildSuggestions

  //   final listaSugerida = (query.isEmpty ) ? peliculaReciente : pelicula.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion = listaSugerida[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }

}
