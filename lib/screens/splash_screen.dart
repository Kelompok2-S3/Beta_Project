import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/utility/Ghost.png', 
              width: 150, 
            )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.5, end: 0, duration: 800.ms, curve: Curves.easeOut),
            
            const SizedBox(height: 20), 
            
            const Text(
              'GEARGAUGE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            )
            .animate(delay: 300.ms) // Staggered delay for text
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.5, end: 0, duration: 800.ms, curve: Curves.easeOut),
          ],
        )
        .animate(delay: 2000.ms, onComplete: (controller) => context.go('/')) // Wait before exit
        .fadeOut(duration: 500.ms)
        .slideY(begin: 0, end: -0.5, duration: 500.ms), // Slide up while fading out
      ),
    );
  }
}