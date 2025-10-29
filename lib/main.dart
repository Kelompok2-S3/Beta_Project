import 'package:beta_project/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brand Showcase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const VideoSplashScreen(), // Set splash screen sebagai home
    );
  }
}
