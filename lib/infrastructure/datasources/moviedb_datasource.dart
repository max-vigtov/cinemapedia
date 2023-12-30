
import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDataSource {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }
    ));
    
  List<Movie> _jsonToMovies( Map<String, dynamic> json){

    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results 
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMappper.movieDBToEntity(moviedb)
      ).toList();
      
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{

    final response =  await dio.get('/movie/now_playing',
      queryParameters: {
        'page': page
      }
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    final response = await dio.get('/movie/popular',
      queryParameters: {
        'page': page
      }
    );
    return _jsonToMovies(response.data);
  }

    @override
  Future<List<Movie>> getUpcoming({int page = 1}) async{
    final response = await dio.get('/movie/upcoming',
      queryParameters: {
        'page': page
      }
    );
    return _jsonToMovies(response.data);
  }  

    @override
  Future<List<Movie>> getTopRated({int page = 1}) async{
    final response = await dio.get('/movie/top_rated',
      queryParameters: {
        'page': page
      }
    );
    return _jsonToMovies(response.data);
  }

}