import 'package:beta_project/BaseData/car_data.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/home_screen.dart';
import 'package:beta_project/screens/splash_screen.dart';
import 'package:beta_project/models/car_model.dart';

final goRouter = GoRouter(
  // Explicitly set the initial location to a unique path for the splash screen.
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash', // The splash screen now has its own dedicated route.
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/', // The root path is now the HomeScreen, which is a more standard setup.
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/car/:name',
      builder: (context, state) {
        final carName = Uri.decodeComponent(state.pathParameters['name']!);
        final allCars = menuCars.values.expand((cars) => cars).toList();
        final car = allCars.firstWhere(
          (car) => car.name == carName,
          orElse: () => carouselCars.isNotEmpty ? carouselCars.first : allCars.first,
        );
        return CarDetailScreen(model: car);
      },
    ),
  ],
);
