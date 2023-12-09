
import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:go_router/go_router.dart';

final approuter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    )

  ]
);