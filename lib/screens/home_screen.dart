import 'package:beta_project/cubits/app_menu/app_menu_cubit.dart';
import 'package:beta_project/cubits/menu_cubit.dart';
import 'package:beta_project/cubits/scroll_cubit.dart';
import 'package:beta_project/widgets/app_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_header.dart';
import '../widgets/cinematic_hero_section.dart';
import '../widgets/models_section.dart';
import '../widgets/promo_section.dart';
import '../widgets/featured_section.dart';
import '../widgets/app_footer.dart';

// =================================================================
// DEFINITIVE FIXED VERSION
// This version restores the full UI with the corrected layout structure.
// The core issue was invisible overlays in a nested Stack blocking taps.
// This new structure places all overlays in a single top-level Stack,
// which correctly handles user interaction.
// =================================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final screenHeight = MediaQuery.of(context).size.height;
    final offset = (_scrollController.offset / screenHeight).clamp(0.0, 1.0);
    // Use a try-catch block for safety when accessing cubits during build/scroll phases.
    try {
      context.read<ScrollCubit>().updateScroll(offset);
    } catch (e) {
      // Cubit might not be available during hot reload or tree changes.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Providing all necessary cubits at the top level of the screen.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MenuCubit()),
        BlocProvider(create: (_) => ScrollCubit()),
        BlocProvider(create: (_) => AppMenuCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        // The main Stack that correctly layers the UI.
        body: Stack(
          children: [
            // 1. The main scrollable content sits at the bottom of the Stack.
            ListView(
              controller: _scrollController,
              children: [
                BlocBuilder<ScrollCubit, double>(
                  builder: (context, scrollOffset) {
                    return CinematicHeroSection(
                      pageOffset: scrollOffset,
                      videoPath: 'assets/videos/Forza4.mp4',
                    );
                  },
                ),
                const ModelsSection(isActive: true),
                const PromoSection(
                  isActive: true,
                  assetPath: 'assets/images/utility/911.jpg',
                  title: 'Our Experience',
                  description: 'Quality and excellence for your vehicle.',
                  buttonText: 'Learn More',
                ),
                const FeaturedSection(isActive: true),
                const AppFooter(isActive: true),
              ],
            ),

            // 2. The AppHeader is positioned on top of the ListView.
            // It is only a visual element and its pointer events are handled correctly.
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: BlocBuilder<ScrollCubit, double>(
                builder: (context, scrollOffset) {
                  return BlocBuilder<MenuCubit, bool>(
                    builder: (context, isMenuOpen) {
                      return AppHeader(
                        pageOffset: scrollOffset,
                        toggleMenu: () => context.read<MenuCubit>().toggleMenu(),
                        isMenuOpen: isMenuOpen,
                      );
                    },
                  );
                },
              ),
            ),

            // 3. The AppMenu is the top-most layer, controlled by AnimatedOpacity and IgnorePointer.
            // This ensures it only blocks taps when it is actually visible.
            BlocBuilder<MenuCubit, bool>(
              builder: (context, isMenuOpen) {
                return AnimatedOpacity(
                  opacity: isMenuOpen ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: IgnorePointer(
                    ignoring: !isMenuOpen,
                    child: AppMenu(
                      isMenuOpen: isMenuOpen,
                      toggleMenu: () => context.read<MenuCubit>().toggleMenu(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
