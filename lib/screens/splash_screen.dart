import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds then navigate to the home screen at the root path '/'.
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Use pushReplacement to navigate to '/' so the user can't go back to the splash screen.
        context.pushReplacement('/');
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
            // 1. Displaying the logo image.
            Image.asset(
              'assets/images/utility/Ghost.png', // Using Ghost.png as the logo.
              width: 150, // Setting a reasonable width for the logo.
            ),
            
            const SizedBox(height: 20), // Space between logo and text.

            // 2. Adding the "BRAND" text below the logo.
            const Text(
              'BRAND',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32, // Slightly smaller font size for balance.
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
