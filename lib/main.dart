import 'package:flutter/material.dart';
import 'package:beta_project/config/app_theme.dart';
import 'package:beta_project/router.dart';

void main() {
  // Kita hapus usePathUrlStrategy() dulu biar jalan lancar
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Brand Showcase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: goRouter,
    );
  }
}s