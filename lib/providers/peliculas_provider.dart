

import 'dart:convert';

import 'package:peliculas/models/pelicula_model.dart';
import 'package:http/http.dart' as http;


class PeliculasProvider{

  String _apiKey = '994459910cc7cf43111169742d09bc90';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

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

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language
    });

    return await _procesarRespuesta(url);
  }

}