import 'package:beta_project/BaseData/car_data.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/home_screen.dart';
import 'package:beta_project/models/car_model.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/car/:name',
      builder: (context, state) {
        final carName = Uri.decodeComponent(state.pathParameters['name']!);
        // Search through all cars available in the app for a more robust routing.
        final allCars = menuCars.values.expand((cars) => cars).toList();
        final car = allCars.firstWhere(
          (car) => car.name == carName,
          // If no car is found, fall back to the first car in the carousel list as a safe default.
          orElse: () => carouselCars.isNotEmpty ? carouselCars.first : allCars.first,
        );
        return CarDetailScreen(model: car);
      },
    ),
  ],
);
