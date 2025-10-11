import 'package:beta_project/models/car_model.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:flutter/material.dart';

class CarModelCard extends StatelessWidget {
  final CarModel model;

  const CarModelCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailScreen(model: model),
          ),
        );
      },
      child: Container(
        width: 500, // Fixed width for each card
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                model.assetPath, 
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 500),
            Text(
              model.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              model.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 100), // Added space at the bottom
          ],
        ),
      ),
    );
  }
}
