import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import paket animasi
import 'home_screen.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {

  void _navigateToHome() {
    // Pastikan widget masih ada di tree sebelum navigasi
    if (mounted) { 
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // Ganti 'assets/images/app_logo.png' dengan path logo atau gambar Anda
        child: Image.asset('assets/images/utility/Ghost.png')
            .animate(onComplete: (controller) => _navigateToHome()) // Navigasi setelah animasi selesai
            .scale(
              begin: const Offset(0.3, 0.3), 
              end: const Offset(1.0, 1.0), 
              duration: 900.ms, 
              curve: Curves.elasticOut
            ) // 1. Efek "pop up" dari kecil ke besar
            .then(delay: 1000.ms) // 2. Jeda selama 1 detik
            .fadeOut(duration: 600.ms), // 3. Efek menghilang perlahan
      ),
    );
  }
}
