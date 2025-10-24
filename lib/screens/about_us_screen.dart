
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/utility/racer.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
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
    const double imageOverlap = 50.0; // How much the image goes off-screen
    final double screenWidth = MediaQuery.of(context).size.width;
    const double imageWidthRatio = 0.65; // Image takes 65% of screen width
    const double textSidePadding = 24.0; // Padding from the screen edge for the text block
    const double textImageGap = 20.0; // Minimum gap between the image and text

    // Calculate the left and right positions for the text block
    double textLeftPosition;
    double textRightPosition;

    if (isImageLeft) {
      // Image is on the left. Text is on the right.
      // Text starts after the visible part of the image + gap
      textLeftPosition = (screenWidth * imageWidthRatio) - imageOverlap + textImageGap;
      // Text ends at the screen edge minus padding
      textRightPosition = textSidePadding;
    } else {
      // Image is on the right. Text is on the left.
      // Text starts at the screen edge plus padding
      textLeftPosition = textSidePadding;
      // Text ends before the visible part of the image + gap
      textRightPosition = (screenWidth * imageWidthRatio) - imageOverlap + textImageGap;
    }

    return SizedBox(
      height: 320, // Fixed height for the Stack to provide a stable canvas
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // --- Clipped Image ---
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

          // --- Text Content ---
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
                  style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                    shadows: [Shadow(color: accentColor.withOpacity(0.7), blurRadius: 10)],
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
                      style: TextStyle(fontSize: 15, color: Colors.grey[300], height: 1.6),
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
            style: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 2,
              shadows: [Shadow(color: accentColor.withOpacity(0.7), blurRadius: 15)],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildValuePillar(
                icon: Icons.timeline,
                title: 'Heritage',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                icon: Icons.speed,
                title: 'Performance',
                accentColor: accentColor,
              ),
              _buildValuePillar(
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

  Widget _buildValuePillar({required IconData icon, required String title, required Color accentColor}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            border: Border.all(color: accentColor.withOpacity(0.5), width: 1),
            boxShadow: [
              BoxShadow(color: accentColor.withOpacity(0.5), blurRadius: 15, spreadRadius: 2),
              BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 20, spreadRadius: 10),
            ],
          ),
          child: Icon(icon, color: accentColor, size: 36),
        ),
        const SizedBox(height: 16),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
