import 'package:flutter/material.dart';
import '../models/brand_model.dart';

class BrandModelCard extends StatelessWidget {
  final BrandModel model;

  const BrandModelCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width for each card
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              model.assetPath, // Changed from model.imageUrl
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              // CHANGED: Replaced bouncing physics with clamping physics for a solid stop.
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
