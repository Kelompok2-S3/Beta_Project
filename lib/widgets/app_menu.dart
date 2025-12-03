import 'package:beta_project/cubits/app_menu/app_menu_cubit.dart';
import 'package:beta_project/cubits/app_menu/app_menu_state.dart';
import 'package:beta_project/data/car_repository.dart';
import 'package:beta_project/domain/entities/car_model.dart';

import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/discover_detail_screen.dart';
import 'package:beta_project/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  final List<String> _mainMenuItems = ['Car Selection', 'Discover', 'Car Specs'];

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
      // ... (existing discover logic)
      widget.toggleMenu();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DiscoverDetailScreen(
            itemTitle: 'Discover Our Fleet',
            itemSubtitle: 'Experience the pinnacle of automotive engineering.',
            assetPath: 'assets/images/utility/oldcars.png',
          ),
        ),
      );
      return;
    }
    if (menuKey == 'Car Specs') {
      widget.toggleMenu();
      context.go('/cars');
      return;
    }
    context.read<AppMenuCubit>().selectMenu(menuKey);
  }
      child: Container(
        // ...
        child: Stack(
          children: [
            // ...
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 60, right: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ...
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
        if (state.selectedMenu != 'Car Selection') {
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
                     setState(() {});
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

        if (state.selectedBrand != null) {
          final models = _carRepository.modelsByBrand[state.selectedBrand] ?? [];
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarDetailScreen(model: model)),
        );
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
