import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final double pageOffset;
  final VoidCallback toggleMenu;
  final bool isMenuOpen;

  const AppHeader({
    super.key,
    required this.pageOffset,
    required this.toggleMenu,
    required this.isMenuOpen,
  });

  Widget _buildNavButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double backgroundOpacity = (pageOffset).clamp(0.0, 1.0);

    // The animated menu button
    final menuButton = IconButton(
      onPressed: toggleMenu,
      icon: AnimatedSwitcher(
        duration: 300.ms,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Icon(
          isMenuOpen ? Icons.close : Icons.menu,
          key: ValueKey<bool>(isMenuOpen), // Important for AnimatedSwitcher
          color: Colors.white,
          size: 28,
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
      ),
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'BRAND',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              // On narrow screens, show only the menu icon
              if (constraints.maxWidth < 768)
                menuButton
              // On wider screens, show the full navigation
              else
                Row(
                  children: [
                    _buildNavButton('Products'),
                    _buildNavButton('Services'),
                    _buildNavButton('About'),
                    menuButton,
                  ],
                ),
            ],
          );
        },
      ),
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: backgroundOpacity * 5.0,
            sigmaY: backgroundOpacity * 5.0,
          ),
          child: Container(
            color: Colors.black.withOpacity(backgroundOpacity * 0.2),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
