import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subTitle, this.loadNextPage
    });

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 350,
      child: Column(
        children: [

          if(title != null || subTitle != null)
            _Title(title: title, subTitle: subTitle,),

          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder:(context, index) {
                return _Slide(movie: movies[index]);
              },
            )
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.movie});
  final Movie movie;
  
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                 if  (loadingProgress != null) {
                   return const Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Center(child: CircularProgressIndicator(strokeWidth: 2,)),
                   );
                 }               
                 return FadeIn(child: child);
                },
              ),
            )
          ),

          const SizedBox(height: 5,),

          //Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          //Rating
          Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
              const SizedBox(width: 3),
              Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
              const SizedBox(width: 20), 
              Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall,)             
            ],
          )
        ],
      ),
    );
  }
}


class _Title extends StatelessWidget {
  const _Title({this.title, this.subTitle});
  
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if(title != null)
          Text(title!, style: titleStyle,),

          const Spacer(),

          if(subTitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: () { },
            child: Text(subTitle!, )),
        ],
      ),
    );
  }
}
