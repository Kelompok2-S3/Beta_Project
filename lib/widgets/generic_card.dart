import 'package:flutter/material.dart';

class GenericCard extends StatelessWidget {
  final String? assetPath;
  final String title;
  final String subtitle;

  const GenericCard({
    super.key,
    this.assetPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Only show the image if an assetPath is provided.
        if (assetPath != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Image.asset(
              assetPath!,
              fit: BoxFit.cover,
              // placeholder and errorWidget are not available for Image.asset
              // You might want to add a default asset image for error/placeholder if needed
            ),
          ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.white70, size: 16),
          ],
        ),
      ],
    );
  }
}
