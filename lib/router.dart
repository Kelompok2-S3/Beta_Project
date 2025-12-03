import 'package:beta_project/data/car_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/home_screen.dart';
import 'package:beta_project/screens/splash_screen.dart';
import 'package:beta_project/screens/auth_screen.dart';
import 'package:beta_project/screens/our_story_screen.dart';
import 'package:beta_project/screens/team_profiles_screen.dart';
import 'package:beta_project/screens/car_list_screen.dart';
import 'package:beta_project/screens/about_app_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/car/:name',
      builder: (context, state) {
        final carName = Uri.decodeComponent(state.pathParameters['name']!);
        final car = CarRepositoryImpl.instance.findCarByName(carName);
        
        // Fallback to a default car if not found
        final fallbackCar = CarRepositoryImpl.instance.carouselCars.isNotEmpty 
            ? CarRepositoryImpl.instance.carouselCars.first 
            : CarRepositoryImpl.instance.allCars.first;

        return CarDetailScreen(model: car ?? fallbackCar);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/our-story',
      builder: (context, state) => const OurStoryScreen(),
    ),
    GoRoute(
      path: '/team-profiles',
      builder: (context, state) => const TeamProfilesScreen(),
    ),
    GoRoute(
      path: '/cars',
      builder: (context, state) => const CarListScreen(),
    ),
    GoRoute(
      path: '/about-app',
      builder: (context, state) => const AboutAppScreen(),
    ),
  ],
);
