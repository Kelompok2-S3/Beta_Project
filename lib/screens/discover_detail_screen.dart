import 'package:beta_project/config/app_theme.dart';
import 'package:flutter/material.dart';
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
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(assetPath),
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
                _FuturisticContentBlock(
                  imagePath: 'assets/images/utility/lemans.png', // Placeholder
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
                  imagePath: 'assets/images/utility/mansory.png', // Placeholder
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
                icon: Icons.precision_manufacturing_outlined,
                title: 'Precision',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                context: context,
                icon: Icons.bolt,
                title: 'Power',
                accentColor: accentColor,
              ),
              _buildValuePillar(
                context: context,
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
