import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beta_project/data/auth_repository.dart';
import 'package:beta_project/cubits/auth_cubit.dart';
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
      child: BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: MaterialApp.router(
          title: 'GearGauge',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: goRouter,
        ),
      ),
    );
  }
}
