import 'package:beta_project/data/car_repository.dart';
import 'package:beta_project/domain/entities/car_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarSearchDelegate extends SearchDelegate<CarModel?> {
  final CarRepositoryImpl carRepository;

  CarSearchDelegate(this.carRepository);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.white,
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This is shown when the user presses the search button on the keyboard
    // We can just show the suggestions here as well
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text('Search for a car by name.', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: FutureBuilder<List<CarModel>>(
        future: carRepository.searchCars(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          
          if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
          }

          final suggestions = snapshot.data ?? [];

          if (suggestions.isEmpty) {
             return const Center(child: Text('No cars found.', style: TextStyle(color: Colors.white54)));
          }

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final car = suggestions[index];
              return ListTile(
                leading: Image.asset(
                  car.assetPath,
                  width: 80,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: Colors.white54),
                ),
                title: Text(car.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text(car.brand, style: const TextStyle(color: Colors.white70)),
                onTap: () {
                  // When a suggestion is tapped, navigate to the detail screen
                  final encodedName = Uri.encodeComponent(car.name);
                  context.push('/car/$encodedName', extra: car);
                },
              );
            },
          );
        },
      ),
    );
  }
}
