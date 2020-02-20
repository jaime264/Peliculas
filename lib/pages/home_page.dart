
import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/card_swipper_widget.dart';
import 'package:peliculas/widgets/footer_swipper_widget.dart';
import 'package:peliculas/widgets/movie_horizontal.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PeliculasProvider peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopular();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                  context: context, 
                  delegate: DataSearch(),
                  //query: 'hola'
                  );
              }
              )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swipperTarjetas(),
              //_footer(),
              _pageView(context)
              ],
          ),
        ));
  }

  Widget _swipperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getPeliculas(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwipper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer() {
    return FutureBuilder(
      future: peliculasProvider.getPopular(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return 
              FooterSwipper(
                peliculas: snapshot.data,
              );
        } else {
          return Container(
              height: 250.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _pageView(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',
            style: Theme.of(context).textTheme.subhead,),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return 
                    MovieHorizontal(
                      peliculas: snapshot.data,
                      siguientePagina: peliculasProvider.getPopular,
                    );
              } else {
                return Container(
                    height: 250.0, child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}
