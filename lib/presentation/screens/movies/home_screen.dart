
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(
        child: _HomeView(),              
      )
    
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

@override
  void initState() {
    super.initState();
  
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    if( slideShowMovies.isEmpty ) return const CircularProgressIndicator();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: Flexible(
            child: CustomAppBar()
            ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
                return Column(
        children: [
              
          MoviesSlideShow(movies: slideShowMovies),
      
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En cines',
            subTitle: 'Lunes 20',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Proxímamente',
            subTitle: 'En este mes',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
      
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Populares',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
      
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Mejor calificadas',
            subTitle: 'Desde Siempre',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),

            const SizedBox(height: 50,)
                  ],
                );
            },
            childCount: 1        
          )
        )
      ]
    );
  }
}