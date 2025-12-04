import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/cubits/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeCubit.toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('Language', style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text('English (Default)', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // Placeholder for language selection
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language selection coming soon!')),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text('App Version', style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text('v1.0.2', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
