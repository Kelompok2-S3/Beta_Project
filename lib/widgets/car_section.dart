import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'car_carousel.dart';

class CarSection extends StatelessWidget {
  final bool isActive;

  const CarSection({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animate the Title individually
          const Text(
            'MODELS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          )
          .animate(target: isActive ? 1 : 0)
          .fade(duration: 900.ms, delay: 200.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

          const SizedBox(height: 50),

          // Animate the Carousel individually with a delay
          const CarCarousel()
          .animate(target: isActive ? 1 : 0)
          .fade(duration: 900.ms, delay: 350.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}
