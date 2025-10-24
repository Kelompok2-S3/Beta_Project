
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 40),

                // --- Section 1: Philosophy ---
                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/apollo.png',
                  title: 'OUR PHILOSOPHY',
                  content:
                      'We believe that every car has a story, a soul.',
                  accentColor: accentColor,
                  imageAlignment: Alignment.centerLeft,
                ).animate().fade(duration: 600.ms).slideX(begin: -0.2, curve: Curves.easeOut),

                const SizedBox(height: 40),

                // --- Section 2: Core Values ---
                _CoreValuesSection(accentColor: accentColor)
                    .animate().fade(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, curve: Curves.easeOut),

                const SizedBox(height: 40),

                // --- Section 3: Legacy ---
                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/f1 old.png',
                  title: 'A LEGACY OF SPEED',
                  content:
                      'to build the most comprehensive and beautifully designed car.',
                  accentColor: accentColor,
                  imageAlignment: Alignment.centerRight, // Alternate alignment
                ).animate().fade(duration: 600.ms).slideX(begin: 0.2, curve: Curves.easeOut),

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
    const double overlap = 50.0;

    // **FIX:** Added a SizedBox to give the Stack a defined height.
    // This prevents the layout from collapsing to zero height.
    return SizedBox(
      height: 300, // Explicit height for the container
      child: Stack(
        clipBehavior: Clip.none, // Allow elements to overlap
        alignment: Alignment.center,
        children: [
          // --- Clipped Image ---
          Positioned(
            top: 10, // Adjust vertical position
            left: isImageLeft ? -overlap : null,
            right: isImageLeft ? null : -overlap,
            child: ClipPath(
              clipper: _AngularClipper(isLeft: isImageLeft),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 280,
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          ),

          // --- Text Content ---
          Positioned.fill(
            child: Align(
              alignment: isImageLeft ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isImageLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: isImageLeft ? TextAlign.right : TextAlign.left,
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
                      margin: EdgeInsets.only(bottom: 12),
                    ),
                    Text(
                      content,
                      textAlign: isImageLeft ? TextAlign.right : TextAlign.left,
                      style: TextStyle(fontSize: 15, color: Colors.grey[300], height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
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
