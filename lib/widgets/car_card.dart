import 'package:flutter/material.dart';
import 'package:beta_project/domain/entities/car_model.dart'; // Updated import

class CarCard extends StatelessWidget {
  final CarModel car; // Changed type to CarModel

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              car.assetPath, // Changed from car.imageUrl
              fit: BoxFit.cover,
            ),

            // Gradient Overlay and Text Content
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Color.fromRGBO(0, 0, 0, 0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      car.description,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
