import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContentSection extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final bool isActive;
  final String assetPath; // Added assetPath

  const ContentSection({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.isActive,
    required this.assetPath, // Added assetPath
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          assetPath, // Changed from CachedNetworkImage
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withAlpha((0.8 * 255).round()), Colors.transparent, Colors.black.withAlpha((0.8 * 255).round())],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animate the Title individually
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    shadows: [Shadow(blurRadius: 8.0, color: Colors.black87)],
                  ),
                )
                .animate(target: isActive ? 1 : 0)
                .fade(duration: 900.ms, delay: 200.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 20),

                // Animate the Description individually with a longer delay
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withAlpha((0.85 * 255).round()),
                    fontSize: 16,
                    height: 1.7,
                    shadows: const [Shadow(blurRadius: 6.0, color: Colors.black54)],
                  ),
                )
                .animate(target: isActive ? 1 : 0)
                .fade(duration: 900.ms, delay: 350.ms) // Increased delay
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 50),

                // Animate the Button individually with the longest delay
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.white12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                )
                .animate(target: isActive ? 1 : 0)
                .fade(duration: 900.ms, delay: 500.ms) // Longest delay
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
