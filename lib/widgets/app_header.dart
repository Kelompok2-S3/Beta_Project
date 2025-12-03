import 'dart:ui';
import 'package:beta_project/data/car_repository.dart';
import 'package:beta_project/screens/about_us_screen.dart';
import 'package:beta_project/screens/discover_detail_screen.dart';
import 'package:beta_project/widgets/car_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beta_project/cubits/app_menu/app_menu_cubit.dart';
import 'package:beta_project/cubits/auth_cubit.dart';
import 'package:go_router/go_router.dart';

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

  Widget _buildNavButton(BuildContext context, String text, {VoidCallback? onPressed}) {
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
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isMenuOpen ? Icons.close : Icons.menu,
          key: ValueKey<bool>(isMenuOpen),
          color: Colors.white,
          size: 28,
        ),
      ),
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.white.withAlpha(26)),
      ),
    );

    final searchButton = IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CarSearchDelegate(CarRepositoryImpl.instance),
        );
      },
      icon: const Icon(Icons.search, color: Colors.white),
      tooltip: 'Search Cars',
    );

    void navigateToAbout() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
      );
    }

    void navigateToServices() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DiscoverDetailScreen(
            itemTitle: 'Discover Our Fleet',
            itemSubtitle: 'Discover the range of services we offer.',
            assetPath: 'assets/images/utility/oldcars.png',
          ),
        ),
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
              if (constraints.maxWidth < 768)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    searchButton,
                    menuButton,
                  ],
                )
              else
                Row(
                  children: [
                    _buildNavButton(context, 'Products', onPressed: () {
                      toggleMenu();
                      try {
                        context.read<AppMenuCubit>().selectMenu('Product');
                      } catch (_) {}
                    }),
                    _buildNavButton(context, 'Discover', onPressed: navigateToServices),
                    _buildNavButton(context, 'About', onPressed: navigateToAbout),
                    searchButton,
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthAuthenticated) {
                          return _buildNavButton(context, 'Logout', onPressed: () {
                            context.read<AuthCubit>().logout();
                          });
                        }
                        return _buildNavButton(context, 'Login', onPressed: () => context.go('/login'));
                      },
                    ),
                    const SizedBox(width: 8),
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
            color: Colors.black.withAlpha((backgroundOpacity * 51).round()),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
