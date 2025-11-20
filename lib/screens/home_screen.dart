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
    try {
      context.read<ScrollCubit>().updateScroll(offset);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MenuCubit()),
        BlocProvider(create: (_) => ScrollCubit()),
        BlocProvider(create: (_) => AppMenuCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
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
            Positioned(
              top: 0, left: 0, right: 0,
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