import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final String assetPath;
  final String title;
  final String subtitle;

  const DiscoverCard({
    super.key,
    required this.assetPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // DEFINITIVE FIX: Constrain the image height to prevent overflow.
          SizedBox(
            height: 220,
            width: double.infinity, // Ensure the SizedBox fills the width of the parent
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              // placeholder and errorWidget are not available for Image.asset
              // You might want to add a default asset image for error/placeholder if needed
            ),
          ),
          const SizedBox(height: 20),
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
      ),
    );
  }
}
