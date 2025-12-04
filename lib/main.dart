import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beta_project/data/auth_repository.dart';
import 'package:beta_project/features/authentication/cubit/auth_cubit.dart'; // Updated import
import 'package:beta_project/cubits/theme_cubit.dart';
import 'package:beta_project/config/app_theme.dart';
import 'package:beta_project/router.dart';

import 'package:beta_project/data/car_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CarRepositoryImpl.instance.initialize();
  // Kita hapus usePathUrlStrategy() dulu biar jalan lancar
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(context.read<AuthRepository>())),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: 'GearGauge',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: goRouter,
            );
          },
        ),
      ),
    );
  }
}
