import 'package:flutter/material.dart';

class Peliculas{
  
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item in jsonList){
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}
class Pelicula {
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Pelicula({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json ){
    posterPath  = json['poster_path'];
    adult       = json['adult'];
    overview    = json['overview'];
    releaseDate = json['release_date'];
    genreIds    = json['genre_ids'].cast<int>();
    id          = json['id'];
    originalTitle = json['original_Title'];
    originalLanguage = json['original_language'];
    title       = json['title'];
    backdropPath = json['backdrop_path'];
    popularity  = json['popularity']/1;
    voteCount   = json['vote_count'];
    video       = json['video'];
    voteAverage = json['vote_average']/1;
  }

  getPosterPath(){
    if(posterPath == null){
      return AssetImage('assets/img/no-image');
    }else{
      return 'https://image.tmdb.org/t/p/w1280$posterPath';
    }
  }

  getBackDropPath(){
    if(posterPath == null){
      return AssetImage('assets/img/no-image');
    }else{
      return 'https://image.tmdb.org/t/p/w1280$backdropPath';
    }
  }
}