
import 'package:beta_project/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Colors.red.shade400;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Our Story',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/utility/racer.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withAlpha(153), // 60% opacity
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // --- Section 1: Philosophy ---
                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/f1 old.png',
                  title: 'OUR PHILOSOPHY',
                  content:
                      'The true magic happens when the city lights fade in the rearview mirror. Out here, the road stretches into the horizon, an endless ribbon of possibility. This isn\'t just transportation; it\'s therapy. It’s the one place where the noise of the world is drowned out by the hum of the engine and the rush of the wind. This is freedom, defined not by a destination, but by the profound, moving solitude of the drive itself.',
                  accentColor: accentColor,
                  imageAlignment: Alignment.centerLeft,
                ).animate().fade(duration: 600.ms).slideX(begin: -0.1, curve: Curves.easeOut),

                const SizedBox(height: 40),

                // --- Section 2: Core Values ---
                _CoreValuesSection(accentColor: accentColor)
                    .animate().fade(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, curve: Curves.easeOut),

                const SizedBox(height: 40),

                // --- Section 3: Legacy ---
                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/apollo.png',
                  title: 'A LEGACY OF SPEED',
                  content:
                      'A car is not just four wheels and an engine; it\'s a canvas for our personality. It’s the color we choose, the sound it makes, the way we maintain it. It becomes an extension of who we are. When you truly love a car, you don\'t just own it; you form a bond with it. You learn its language, feel its imperfections, and celebrate its strengths. It\'s a mechanical soulmate',
                  accentColor: accentColor,
                  imageAlignment: Alignment.centerRight, // Alternate alignment
                ).animate().fade(duration: 600.ms).slideX(begin: 0.1, curve: Curves.easeOut),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Main Widget for Asymmetrical Content ---
class _FuturisticContentBlock extends StatelessWidget {
  final String imagePath, title, content;
  final Color accentColor;
  final Alignment imageAlignment;

  const _FuturisticContentBlock({
    required this.imagePath,
    required this.title,
    required this.content,
    required this.accentColor,
    this.imageAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    final bool isImageLeft = imageAlignment == Alignment.centerLeft;
    const double imageOverlap = 50.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    const double imageWidthRatio = 0.65;
    const double textSidePadding = 24.0;
    const double textImageGap = 20.0;

    double textLeftPosition;
    double textRightPosition;

    if (isImageLeft) {
      textLeftPosition = (screenWidth * imageWidthRatio) - imageOverlap + textImageGap;
      textRightPosition = textSidePadding;
    } else {
      textLeftPosition = textSidePadding;
      textRightPosition = (screenWidth * imageWidthRatio) - imageOverlap + textImageGap;
    }

    return SizedBox(
      height: 320,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            left: isImageLeft ? -imageOverlap : null,
            right: isImageLeft ? null : -imageOverlap,
            child: ClipPath(
              clipper: _AngularClipper(isLeft: isImageLeft),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 280,
                width: screenWidth * imageWidthRatio,
              ),
            ),
          ),
          Positioned(
            top: 40,
            bottom: 40,
            left: textLeftPosition,
            right: textRightPosition,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: isImageLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: isImageLeft ? TextAlign.left : TextAlign.right,
                  style: AppTheme.orbitronTitle2.copyWith(
                    shadows: [Shadow(color: accentColor.withAlpha(179), blurRadius: 10)], // 70% opacity
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 80,
                  height: 2,
                  color: accentColor,
                  margin: const EdgeInsets.only(bottom: 12),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      textAlign: isImageLeft ? TextAlign.left : TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ).animate(delay: 300.ms).fade(duration: 600.ms).slideX(begin: isImageLeft ? 0.2 : -0.2, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }
}


// --- Custom Clipper for Angular Shape ---
class _AngularClipper extends CustomClipper<Path> {
  final bool isLeft;
  _AngularClipper({required this.isLeft});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width * 0.8, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width * 0.2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// --- Redesigned Core Values Section ---
class _CoreValuesSection extends StatelessWidget {
  final Color accentColor;
  const _CoreValuesSection({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Text(
            'CORE VALUES',
            style: AppTheme.orbitronTitle1.copyWith(
              shadows: [Shadow(color: accentColor.withAlpha(179), blurRadius: 15)], // 70% opacity
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildValuePillar(
                context: context,
                icon: Icons.timeline,
                title: 'Heritage',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                context: context,
                icon: Icons.speed,
                title: 'Performance',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                context: context,
                icon: Icons.people_alt,
                title: 'Community',
                accentColor: accentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValuePillar({required BuildContext context, required IconData icon, required String title, required Color accentColor}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            border: Border.all(color: accentColor.withAlpha(128), width: 1), // 50% opacity
            boxShadow: [
              BoxShadow(color: accentColor.withAlpha(128), blurRadius: 15, spreadRadius: 2), // 50% opacity
              BoxShadow(color: Colors.black.withAlpha(179), blurRadius: 20, spreadRadius: 10), // 70% opacity
            ],
          ),
          child: Icon(icon, color: accentColor, size: 36),
        ),
        const SizedBox(height: 16),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
