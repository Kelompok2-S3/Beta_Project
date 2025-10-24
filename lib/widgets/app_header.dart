
import 'dart:ui';
import 'package:beta_project/screens/about_us_screen.dart';
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

  // Updated to accept an optional onPressed callback
  Widget _buildNavButton(String text, {VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(
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
          key: ValueKey<bool>(isMenuOpen),
          color: Colors.white,
          size: 28,
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
      ),
    );

    // Function to navigate to the About Us screen
    void navigateToAbout() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
      );
    }

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

              // On narrow screens, show icons for About Us and Menu
              if (constraints.maxWidth < 768)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: navigateToAbout,
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                      tooltip: 'About Us',
                    ),
                    menuButton,
                  ],
                )
              // On wider screens, show the full navigation
              else
                Row(
                  children: [
                    _buildNavButton('Products'),
                    _buildNavButton('Services'),
                    _buildNavButton('About', onPressed: navigateToAbout),
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
