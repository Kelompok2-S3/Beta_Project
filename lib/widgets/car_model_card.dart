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
        width: 300, // Reduced width for a more compact card
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200, // Reduced image height
              width: double.infinity,
              child: Image.asset(
                model.assetPath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10), // Drastically reduced space to fix overflow
            Text(
              model.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1, // Prevent text from wrapping and causing overflow
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              model.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              maxLines: 2, // Limit description to 2 lines
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
