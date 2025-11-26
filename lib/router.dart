import 'package:beta_project/data/car_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/home_screen.dart';
import 'package:beta_project/screens/splash_screen.dart';

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
        final car = CarRepository.instance.findCarByName(carName);
        
        // Fallback to a default car if not found
        final fallbackCar = CarRepository.instance.carouselCars.isNotEmpty 
            ? CarRepository.instance.carouselCars.first 
            : CarRepository.instance.allCars.first;

        return CarDetailScreen(model: car ?? fallbackCar);
      },
    ),
  ],
);
