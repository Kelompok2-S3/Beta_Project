import 'package:beta_project/data/car_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/features/car/pages/car_detail_screen.dart';
import 'package:beta_project/features/home/pages/home_screen.dart';
import 'package:beta_project/features/splash/pages/splash_screen.dart';
import 'package:beta_project/features/authentication/pages/auth_screen.dart';
import 'package:beta_project/features/about/pages/our_story_screen.dart';
import 'package:beta_project/features/about/pages/team_profiles_screen.dart';
import 'package:beta_project/features/car/pages/car_list_screen.dart';
import 'package:beta_project/features/about/pages/about_app_screen.dart';
import 'package:beta_project/features/profile/pages/profile_screen.dart';
import 'package:beta_project/features/discover/pages/discover_detail_screen.dart';
import 'package:beta_project/features/discover/pages/experience_detail_screen.dart'; // New import

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
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/discover-detail',
      builder: (context, state) {
        final itemTitle = state.extra as String?;
        final itemSubtitle = state.uri.queryParameters['subtitle'] ?? '';
        final assetPath = state.uri.queryParameters['assetPath'] ?? '';
        return DiscoverDetailScreen(
          itemTitle: itemTitle ?? 'Discover Item',
          itemSubtitle: itemSubtitle,
          assetPath: assetPath,
        );
      },
    ),
    GoRoute(
      path: '/experience-detail',
      builder: (context, state) {
        final experienceTitle = state.uri.queryParameters['title'] ?? 'Experience Detail';
        final experienceDescription = state.uri.queryParameters['description'] ?? '';
        final imageUrl = state.uri.queryParameters['imageUrl'];
        final assetPath = state.uri.queryParameters['assetPath'];
        return ExperienceDetailScreen(
          experienceTitle: experienceTitle,
          experienceDescription: experienceDescription,
          imageUrl: imageUrl,
          assetPath: assetPath,
        );
      },
    ),
  ],
);
