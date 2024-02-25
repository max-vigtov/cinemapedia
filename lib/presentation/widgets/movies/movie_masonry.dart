import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {

  const MovieMasonry({
    super.key, 
    required this.movies, 
    this.loadNextPage
  });

  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

 final scrollController = ScrollController();

@override
  void initState() {
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;

      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
    super.initState();    
  }

@override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          if(index == 1){
            return Column(
              children: [
                const SizedBox(height: 40,),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }
        return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}