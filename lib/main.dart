import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart'; // Import splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData darkTheme = ThemeData.dark();

    return MaterialApp(
      title: 'Brand Showcase',
      debugShowCheckedModeBanner: false,
      theme: darkTheme.copyWith(
        textTheme: GoogleFonts.montserratTextTheme(darkTheme.textTheme),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const VideoSplashScreen(), // Set splash screen sebagai home
    );
  }
}
