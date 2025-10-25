import 'package:beta_project/data/car_database.dart';
import 'package:beta_project/models/car_model.dart';
import 'package:beta_project/screens/about_us_screen.dart';
import 'package:beta_project/screens/car_detail_screen.dart';
import 'package:beta_project/screens/discover_detail_screen.dart'; // Import DiscoverDetailScreen
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

  String? _selectedMenu;
  String? _selectedBrand;

  final Map<String, List<String>> _brandsByLetter = {};
  final Map<String, List<CarModel>> _modelsByBrand = {};

  // Add 'Discover' to the main menu items
  final List<String> _mainMenuItems = ['Product', 'Discover', 'About'];

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(vsync: this, duration: 600.ms);
    _subController = AnimationController(vsync: this, duration: 400.ms);

    for (var car in allCars) {
      if (!_modelsByBrand.containsKey(car.brand)) {
        _modelsByBrand[car.brand] = [];
      }
      _modelsByBrand[car.brand]!.add(car);
    }

    List<String> brands = _modelsByBrand.keys.toList();
    brands.sort();
    for (var brand in brands) {
      if (brand.isNotEmpty) {
        String firstLetter = brand.substring(0, 1).toUpperCase();
        if (!_brandsByLetter.containsKey(firstLetter)) {
          _brandsByLetter[firstLetter] = [];
        }
        _brandsByLetter[firstLetter]!.add(brand);
      }
    }
  }

  @override
  void didUpdateWidget(covariant AppMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMenuOpen) {
      _mainController.forward();
    } else {
      _mainController.reverse();
      setState(() {
        _selectedMenu = null;
        _selectedBrand = null;
      });
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _subController.dispose();
    super.dispose();
  }

  void _onMainMenuSelected(String menuKey) {
    // Handle navigation for 'About' and 'Discover'
    if (menuKey == 'About') {
      widget.toggleMenu();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
      );
      return;
    } else if (menuKey == 'Discover') {
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

    // Handle submenu for 'Product'
    setState(() {
      if (_selectedMenu == menuKey) {
        _selectedMenu = null;
        _selectedBrand = null;
        _subController.reverse();
      } else {
        _selectedMenu = menuKey;
        _selectedBrand = null;
        _subController.forward(from: 0.0);
      }
    });
  }

  void _onBrandSelected(String brandKey) {
    setState(() {
      _selectedBrand = brandKey;
      _subController.forward(from: 0.0);
    });
  }

  void _onBackToBrands() {
    setState(() {
      _selectedBrand = null;
      _subController.reverse().then((_) => _subController.forward());
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isMenuOpen,
      child: Animate(
        target: widget.isMenuOpen ? 1.0 : 0.0,
        effects: [FadeEffect(duration: 600.ms, curve: Curves.easeInOut)],
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
                          children: _mainMenuItems.map((key) => _buildMainMenuItem(key)).toList(),
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
      ),
    );
  }

  Widget _buildMainMenuItem(String text) {
    final bool isSelected = _selectedMenu == text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: GestureDetector(
        onTap: () => _onMainMenuSelected(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.white.withAlpha(180),
          ),
        ),
      ),
    ).animate(controller: _mainController).slideX(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOutCubic).fadeIn();
  }

  Widget _buildSubMenu() {
    if (_selectedMenu != 'Product') {
      return const SizedBox.shrink();
    }

    if (_selectedBrand != null) {
      final models = _modelsByBrand[_selectedBrand] ?? [];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton('Back to Brands'),
          Expanded(
            child: ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) => _buildModelMenuItem(models[index]),
            ),
          ),
        ],
      );
    }

    final letters = _brandsByLetter.keys.toList();
    return ListView.builder(
      itemCount: letters.length,
      itemBuilder: (context, index) {
        final letter = letters[index];
        final brands = _brandsByLetter[letter]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(letter, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            ...brands.map((brand) => _buildBrandMenuItem(brand)).toList(),
          ],
        );
      },
    );
  }

  Widget _buildBrandMenuItem(String brand) {
    return GestureDetector(
      onTap: () => _onBrandSelected(brand),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(brand, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70)),
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
        child: Text(model.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70)),
      ),
    ).animate(controller: _subController).slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic).fadeIn();
  }

  Widget _buildBackButton(String text) {
    return GestureDetector(
      onTap: _onBackToBrands,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: Colors.white70, size: 16),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70)),
          ],
        ),
      ),
    ).animate(controller: _subController).slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic).fadeIn();
  }
}
