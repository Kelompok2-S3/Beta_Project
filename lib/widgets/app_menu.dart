import 'package:beta_project/features/home/cubit/app_menu_cubit.dart';
import 'package:beta_project/features/home/cubit/app_menu_state.dart';
import 'package:beta_project/data/car_repository.dart';
import 'package:beta_project/domain/entities/car_model.dart';

import 'package:beta_project/features/car/pages/car_detail_screen.dart';
import 'package:beta_project/features/discover/pages/discover_detail_screen.dart';
import 'package:beta_project/features/authentication/cubit/auth_cubit.dart'; // Updated import
// import 'package:beta_project/features/authentication/cubit/auth_state.dart'; // Removed
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/widgets/login_required_dialog.dart';

class AppMenu extends StatefulWidget {
  final bool isMenuOpen;
  final VoidCallback toggleMenu;

  const AppMenu({
    super.key,
    required this.isMenuOpen,
    required this.toggleMenu,
  });

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _subController;

  // Data is now fetched from the repository
  final _carRepository = CarRepositoryImpl.instance;
  final List<String> _mainMenuItems = ['Car Selection', 'Discover', 'Car Specs', 'About App', 'Profile'];

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(vsync: this, duration: 600.ms);
    _subController = AnimationController(vsync: this, duration: 400.ms);
    
    // If menu opens initially (unlikely but possible), forward animation
    if (widget.isMenuOpen) {
      _mainController.forward();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _subController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMenuOpen != oldWidget.isMenuOpen) {
      if (widget.isMenuOpen) {
        _mainController.forward(from: 0.0);
      } else {
        _mainController.reverse();
      }
    }
  }

  void _onMainMenuSelected(String menuKey) {
    if (menuKey == 'Discover') {
      widget.toggleMenu();
      // Menggunakan context.go untuk navigasi GoRouter
      context.go('/discover-detail?subtitle=${Uri.encodeComponent('Experience the pinnacle of automotive engineering.')}&assetPath=${Uri.encodeComponent('assets/images/utility/oldcars.png')}', extra: 'Discover Our Fleet');
      return;
    }
    if (menuKey == 'Car Specs') {
      widget.toggleMenu();
      context.go('/cars');
      return;
    }
    if (menuKey == 'About App') {
      widget.toggleMenu();
      context.go('/about-app');
      return;
    }
    if (menuKey == 'Profile') {
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthAuthenticated) {
        widget.toggleMenu();
        context.go('/profile');
      } else {
        // Show Login Required Dialog
        showDialog(
          context: context,
          builder: (context) => const LoginRequiredDialog(),
        );
      }
      return;
    }
    context.read<AppMenuCubit>().selectMenu(menuKey);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppMenuCubit, AppMenuState>(
      listener: (context, state) {
        if (state.selectedMenu == 'Car Selection' || state.selectedBrand != null) {
          _subController.forward(from: 0.0);
        } else {
          _subController.reverse();
        }
        
        // Fetch models if brand is selected
        if (state.selectedBrand != null) {
           _fetchModelsForBrand(state.selectedBrand!);
        }
      },
      child: Container(
        color: Colors.black.withAlpha(230),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: widget.toggleMenu,
              ).animate(controller: _mainController).fade(duration: 400.ms, delay: 200.ms),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 60, right: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._mainMenuItems.map((key) => _buildMainMenuItem(key)),
                          _buildAuthMenuItem(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: _buildSubMenu(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMenuItem(String text) {
    return BlocBuilder<AppMenuCubit, AppMenuState>(
      builder: (context, state) {
        final bool isSelected = state.selectedMenu == text;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
            onTap: () => _onMainMenuSelected(text),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
            ),
          ),
        ).animate(controller: _mainController).slideX(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOutCubic).fadeIn();
      },
    );
  }

  Widget _buildAuthMenuItem() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final bool isAuthenticated = state is AuthAuthenticated;
        final String text = isAuthenticated ? 'Logout' : 'Login';
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
            onTap: () {
              if (isAuthenticated) {
                context.read<AuthCubit>().logout();
                widget.toggleMenu(); // Close menu after logout
              } else {
                widget.toggleMenu(); // Close menu before navigating
                context.go('/login');
              }
            },
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
            ),
          ),
        ).animate(controller: _mainController).slideX(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOutCubic).fadeIn();
      },
    );
  }


  Future<void> _fetchModelsForBrand(String brand) async {
    // Check if we already have models, if not fetch
    if (_carRepository.modelsByBrand[brand]?.isEmpty ?? true) {
      await _carRepository.fetchModelsForBrand(brand);
      if (mounted) setState(() {});
    }
  }

  // ...

  Widget _buildSubMenu() {
    return BlocBuilder<AppMenuCubit, AppMenuState>(
      builder: (context, state) {
        // Handle nullable selectedMenu and selectedBrand
        final selectedMenu = state.selectedMenu;
        final selectedBrand = state.selectedBrand;

        if (selectedMenu != 'Car Selection') {
          return const SizedBox.shrink();
        }

        // ... (Retry logic)
        if (_carRepository.brandsByLetter.isEmpty) {
           // ... (Retry UI)
           return Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   "No cars data available.\nPlease check server connection.",
                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white54),
                 ),
                 const SizedBox(height: 16),
                 ElevatedButton.icon(
                   onPressed: () async {
                     await _carRepository.initialize();
                     if (mounted) setState(() {});
                   },
                   icon: const Icon(Icons.refresh),
                   label: const Text("Retry Connection"),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white24,
                     foregroundColor: Colors.white,
                   ),
                 ),
               ],
             ),
           );
        }

        if (selectedBrand != null) {
          final models = _carRepository.modelsByBrand[selectedBrand] ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton('Back to Brands'),
              if (models.isEmpty)
                 const Padding(
                   padding: EdgeInsets.all(20.0),
                   child: CircularProgressIndicator(color: Colors.white),
                 )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: models.length,
                    itemBuilder: (context, index) => _buildModelMenuItem(models[index]),
                  ),
                ),
            ],
          );
        }

        final letters = _carRepository.brandsByLetter.keys.toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Choose Your Car",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: letters.length,
                itemBuilder: (context, index) {
                  final letter = letters[index];
                  final brands = _carRepository.brandsByLetter[letter]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(letter, style: Theme.of(context).textTheme.titleLarge),
                      ),
                      ...brands.map((brand) => _buildBrandMenuItem(brand)),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBrandMenuItem(String brand) {
    return GestureDetector(
      onTap: () => context.read<AppMenuCubit>().selectBrand(brand),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(brand, style: Theme.of(context).textTheme.titleMedium),
      ),
    ).animate(controller: _subController).slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic).fadeIn();
  }

  Widget _buildModelMenuItem(CarModel model) {
    return GestureDetector(
      onTap: () {
        // Use context.push to navigate to a named route, passing the model as an extra
        context.push('/car/${Uri.encodeComponent(model.name)}', extra: model);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(model.name, style: Theme.of(context).textTheme.titleMedium),
      ),
    ).animate(controller: _subController).slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic).fadeIn();
  }

  Widget _buildBackButton(String text) {
    return GestureDetector(
      onTap: () {
        context.read<AppMenuCubit>().backToBrands();
        _subController.reverse().then((_) => _subController.forward());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: Colors.white70, size: 16),
            const SizedBox(width: 8),
            Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    ).animate(controller: _subController).slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic).fadeIn();
  }
}
