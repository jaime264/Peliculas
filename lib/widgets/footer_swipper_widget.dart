import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/models/pelicula_model.dart';

class FooterSwipper extends StatelessWidget {
  final List<Pelicula> peliculas;
  FooterSwipper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      padding: EdgeInsets.all(20.0),
      child: Swiper(
        layout: SwiperLayout.DEFAULT,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getBackDropPath()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
            )
          );
        },
        itemCount: peliculas.length,
        ),
    );
  }
}