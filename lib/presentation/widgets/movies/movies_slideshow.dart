import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
class MoviesSlideShow extends StatelessWidget {
  const MoviesSlideShow({super.key, required this.movies});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        autoplay: true,
        viewportFraction: 0.8,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: color.primary,
            color: color.secondary
          )
        ),
        itemCount: movies.length,
        scale: 0.9,
        itemBuilder: (context, index) => _Slide(movie: movies[index])              
        ),
    );
  }
}

class _Slide extends StatelessWidget {

  _Slide({required this.movie});

  final decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.black45,
        blurRadius: 10,
        offset: Offset(0, 10)
      )
    ]
  );
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:  Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress != null){
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12));
              }
              return FadeIn(child: child);
            },
          )
         )
        ),
    );
  }
}