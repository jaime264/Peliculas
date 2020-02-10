

import 'dart:async';
import 'dart:convert';

import 'package:peliculas/models/pelicula_model.dart';
import 'package:http/http.dart' as http;


class PeliculasProvider{

  String _apiKey = '994459910cc7cf43111169742d09bc90';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;
 
  List<Pelicula> _populares = new List();

  final _popularStreamController = new StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularStreamController.stream;

  void disposeStream(){
    _popularStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    
    final resp = await http.get(url);
    final jsonList = json.decode(resp.body);

    Peliculas peliculas = new Peliculas.fromJsonList(jsonList['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getPeliculas() async{

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    return await _procesarRespuesta(url);
  }


  Future<List<Pelicula>> getPopular() async{

    if(_cargando) return [];

    _cargando = true;
    _popularesPage++;

    print('Cargando populares');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final result = await _procesarRespuesta(url);

    _populares.addAll(result);
    popularesSink(_populares);

    _cargando = false;
    return result;
  }

}