import 'package:beta_project/widgets/car_carousel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart'; // No longer needed here

class ModelsSection extends StatelessWidget {
  final bool isActive;

  const ModelsSection({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    // This section now acts as a container for the CarCarousel
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [ // Now a const Column
          Text(
            'Featured Models',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          // The CarCarousel now holds the correct models and logic
          CarCarousel(),
        ],
      ),
      // .animate().fadeIn() has been removed as it was likely blocking taps.
    );
  }
}
