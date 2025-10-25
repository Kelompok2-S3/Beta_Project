import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    // Navigasi setelah jeda waktu tertentu
    Timer(const Duration(milliseconds: 3500), () { // Total durasi animasi + jeda
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo dengan animasi fade-in, scale-up, blur, dan rotate
            Image.asset('assets/images/utility/Ghost.png', height: 150)
                .animate()
                .fadeIn(duration: 900.ms, curve: Curves.easeOutCubic)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), duration: 900.ms, curve: Curves.easeOutCubic)
                .blur(begin: const Offset(5, 5), end: const Offset(0, 0), duration: 900.ms, curve: Curves.easeOutCubic)
                .rotate(begin: -0.05, end: 0, duration: 900.ms, curve: Curves.easeOutCubic),

            const SizedBox(height: 20),

            // Nama brand dengan animasi menggunakan Animate widget dan shimmer
            Animate(
              effects: [
                FadeEffect(delay: 500.ms, duration: 900.ms, curve: Curves.easeOutCubic),
                SlideEffect(delay: 500.ms, begin: const Offset(0, 1), end: Offset.zero, duration: 900.ms, curve: Curves.easeOutCubic),
                ShimmerEffect(delay: 1500.ms, duration: 1000.ms, color: Colors.white.withOpacity(0.5)), // Efek shimmer
              ],
              child: Text(
                'BRANDS',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
