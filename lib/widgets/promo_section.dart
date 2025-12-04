import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:beta_project/features/discover/pages/experience_detail_screen.dart'; // Updated import
import 'package:go_router/go_router.dart'; // Added import for GoRouter

class PromoSection extends StatelessWidget {
  final bool isActive;
  final String assetPath; // Reverted back to assetPath
  final String title;
  final String description;
  final String buttonText;

  const PromoSection({
    super.key,
    required this.isActive,
    required this.assetPath, // Reverted back to assetPath
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath), // Use AssetImage
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
  color: Colors.black.withAlpha((0.5 * 255).round()),
        padding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              OutlinedButton(
                onPressed: () {
                  // Membangun URL dengan parameter kueri secara langsung
                  context.go(
                    '/experience-detail?title=${Uri.encodeComponent(title)}&description=${Uri.encodeComponent(description)}&assetPath=${Uri.encodeComponent(assetPath)}',
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOut),
        ),
      ),
    );
  }
}
