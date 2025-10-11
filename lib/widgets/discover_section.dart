import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'discover_card.dart';

class DiscoverSection extends StatelessWidget {
  const DiscoverSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Discover',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          // DEFINITIVE FIX: Simplified the layout by removing one card to prevent all overflow issues.
          const DiscoverCard(
            assetPath: 'assets/images/Porsche/Porsche_Porsche_911_GT3_RS_(2023).png', // Corrected the asset path
            title: 'The new 911 GT3 RS',
            subtitle: 'Find out more',
          ),
        ],
      ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOut),
    );
  }
}
