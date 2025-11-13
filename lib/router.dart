import 'package:beta_project/BaseData/car_data.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/home_screen.dart';

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
        final car = carouselCars.firstWhere((car) => car.name == carName, orElse: () => carouselCars.first);
        return CarDetailScreen(model: car);
      },
    ),
  ],
);
