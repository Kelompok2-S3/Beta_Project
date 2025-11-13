import 'dart:ui';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  // This is the crucial input from the PageView (0.0 to N)
  final double pageOffset;

  const Header({super.key, required this.pageOffset});

  Widget _navLink(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(foregroundColor: Colors.white12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The frosted glass effect should only appear when scrolling away from the first page (page 0).
    // We calculate the opacity of the effect based on the transition from page 0 to 1.
    final double backgroundOpacity = (pageOffset).clamp(0.0, 1.0);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Koenigsegg Shield Logo
          Image.network(
            'https://www.koenigsegg.com/wp-content/uploads/2020/02/shield.png',
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.menu, color: Colors.white, size: 28), onPressed: () {}),
                    _navLink('MODELS'),
                    _navLink('BRAND'),
                  ],
                ),
                Row(
                  children: [
                    _navLink('LEGACY'),
                    _navLink('CAREERS'),
                    IconButton(icon: const Icon(Icons.language, color: Colors.white, size: 28), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // The flexibleSpace is used to create the animated frosted glass background.
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            // The blur is animated based on the background opacity.
            sigmaX: backgroundOpacity * 5.0,
            sigmaY: backgroundOpacity * 5.0,
          ),
          child: Container(
            // The container's color provides the tint for the frosted glass effect.
            // It animates from fully transparent to a semi-transparent black.
            color: Colors.black.withAlpha((backgroundOpacity * 0.2 * 255).round()),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
