
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

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    textTheme: GoogleFonts.montserratTextTheme(
      const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black, shadows: [Shadow(blurRadius: 10.0, color: Colors.grey)]),
        headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 5),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black87),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black87),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1.2),
        bodyLarge: TextStyle(fontSize: 18, color: Colors.black, shadows: [Shadow(blurRadius: 8.0, color: Colors.grey)]),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 15, color: Color(0xFF424242), height: 1.6),
      ),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
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
