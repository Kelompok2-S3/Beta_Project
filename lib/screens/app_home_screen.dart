import 'package:beta_project/widgets/app_menu.dart';
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/cinematic_hero_section.dart';
import '../widgets/models_section.dart';
import '../widgets/video_promo_section.dart';
import '../widgets/featured_section.dart';
import '../widgets/app_footer.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
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
      // Normalize the scroll offset to a 0.0-1.0 range for the first screen
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
    // A single list of widgets for a continuous scrolling experience
    final List<Widget> sections = [
      CinematicHeroSection(
        pageOffset: _scrollOffset,
        videoPath: 'assets/videos/Forza4.mp4',
      ),
      const ModelsSection(isActive: true),
      // --- Path video diperbarui untuk VideoPromoSection ---
      const VideoPromoSection(
        isActive: true,
        imagePath: 'assets/images/utility/911.jpg', // Menggunakan gambar
        title: 'Our Services',
        description: 'Quality and excellence for your vehicle.',
        buttonText: 'Learn More',
      ),
      const FeaturedSection(isActive: true),
      const AppFooter(isActive: true),
    ];

    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      body: Stack(
        children: [
          // Use a ListView for smooth, continuous scrolling
          ListView(
            controller: _scrollController,
            children: sections,
          ),
          // The Header, which animates based on scroll
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
          // The App-style menu
          AppMenu(
            isMenuOpen: _isMenuOpen,
            toggleMenu: _toggleMenu,
          ),
        ],
      ),
    );
  }
}
