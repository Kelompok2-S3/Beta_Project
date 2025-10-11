import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData darkTheme = ThemeData.dark();

    return MaterialApp(
      title: 'Brand Showcase', // Generic title
      debugShowCheckedModeBanner: false,
      theme: darkTheme.copyWith(
        textTheme: GoogleFonts.montserratTextTheme(darkTheme.textTheme),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(), // Use the new home screen
    );
  }
}
