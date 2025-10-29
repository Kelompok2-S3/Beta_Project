
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Tema utama menggunakan Montserrat
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.montserratTextTheme(
      const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(blurRadius: 10.0, color: Colors.black54)]),
        headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 5),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white70),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
        bodyLarge: TextStyle(fontSize: 18, color: Colors.white, shadows: [Shadow(blurRadius: 8.0, color: Colors.black54)]),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
        bodySmall: TextStyle(fontSize: 15, color: Color(0xFFBDBDBD), height: 1.6), // Colors.grey[300] is 0xFFBDBDBD
      ),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );

  // Gaya teks khusus untuk font Orbitron
  static TextStyle get orbitronTitle1 => GoogleFonts.orbitron(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: Colors.white,
    letterSpacing: 2,
  );

  static TextStyle get orbitronTitle2 => GoogleFonts.orbitron(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.white,
  );
}
