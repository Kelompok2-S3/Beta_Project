import 'package:beta_project/widgets/app_menu.dart';
import 'package:flutter/material.dart';
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
  double _scrollOffset = 0.0;
  bool _isMenuOpen = false;

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
    setState(() {
      _scrollOffset = (_scrollController.offset / screenHeight).clamp(0.0, 1.0);
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      CinematicHeroSection(
        pageOffset: _scrollOffset,
        videoPath: 'assets/videos/Forza4.mp4',
      ),
      const ModelsSection(isActive: true),
      const PromoSection(
        isActive: true,
        assetPath: 'assets/images/utility/911.jpg',
        title: 'Our Experience', // Changed from 'Our Services'
        description: 'Quality and excellence for your vehicle.',
        buttonText: 'Learn More',
      ),
      const FeaturedSection(isActive: true),
      const AppFooter(isActive: true),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: sections,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppHeader(
              pageOffset: _scrollOffset,
              toggleMenu: _toggleMenu,
              isMenuOpen: _isMenuOpen,
            ),
          ),
          AnimatedOpacity(
            opacity: _isMenuOpen ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: IgnorePointer(
              ignoring: !_isMenuOpen,
              child: AppMenu(
                isMenuOpen: _isMenuOpen,
                toggleMenu: _toggleMenu,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
