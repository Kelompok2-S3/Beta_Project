import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DiscoverDetailScreen extends StatelessWidget {
  final String itemTitle;
  final String itemSubtitle;
  final String assetPath;

  const DiscoverDetailScreen({
    super.key,
    required this.itemTitle,
    required this.itemSubtitle,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Colors.teal.shade400;

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
                itemTitle,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(assetPath), // Changed to use AssetImage directly
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
                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/apollo.png', // Placeholder
                  title: 'INNOVATION IN MOTION',
                  content:
                      'Our fleet represents the pinnacle of automotive innovation. Each vehicle is engineered with cutting-edge technology, delivering a dynamic and responsive driving experience that connects you to the road like never before.',
                  accentColor: accentColor,
                  imageAlignment: Alignment.centerLeft,
                ).animate().fade(duration: 600.ms).slideX(begin: -0.1, curve: Curves.easeOut),

                const SizedBox(height: 40),

                _CoreValuesSection(accentColor: accentColor)
                    .animate().fade(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, curve: Curves.easeOut),

                const SizedBox(height: 40),

                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/f1 old.png', // Placeholder
                  title: 'DESIGN THAT INSPIRES',
                  content:
                      'Beyond performance, our vehicles are a statement of style. The aerodynamic lines, luxurious interiors, and bold presence are designed to inspire awe and admiration, making every journey an event.',
                  accentColor: accentColor,
                  imageAlignment: Alignment.centerRight,
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
            'KEY PILLARS',
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
                icon: Icons.precision_manufacturing_outlined,
                title: 'Precision',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                icon: Icons.bolt,
                title: 'Power',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                icon: Icons.verified_user_outlined,
                title: 'Prestige',
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
