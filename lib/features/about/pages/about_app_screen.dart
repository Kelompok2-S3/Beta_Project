import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background Bubbles
          const Positioned.fill(child: BubblesBackground()),
          
          // 2. Content
          SafeArea(
            child: Column(
              children: [
                // Header with Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.canPop() ? context.pop() : context.go('/'),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/utility/ghost.png',
                            fit: BoxFit.contain,
                          ),
                        ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                        
                        const SizedBox(height: 24),
                        
                        // Title
                        Text(
                          'About GearGauge',
                          style: GoogleFonts.orbitron(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                        
                        const SizedBox(height: 12),
                        
                        Text(
                          'The Ultimate Exotic Car Encyclopedia',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 200.ms),
                        
                        const SizedBox(height: 40),
                        
                        // Description
                        _buildSectionText(
                          'GearGauge is a premier digital destination designed for automotive enthusiasts, collectors, and dreamers. We bridge the gap between digital exploration and the visceral experience of the world\'s most exclusive machines.',
                        ),
                        
                        const SizedBox(height: 24),
                        
                        _buildSectionText(
                          'Our mission is to provide an immersive, detailed, and visually stunning platform where users can discover, analyze, and appreciate the engineering marvels of the automotive world. From the roaring V12s of Italy to the precision engineering of Germany, GearGauge covers it all.',
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Features List
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Key Features',
                            style: GoogleFonts.orbitron(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFD5001C),
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms),
                        
                        const SizedBox(height: 16),
                        
                        _buildFeatureItem('Comprehensive Database', 'Access detailed specifications for hundreds of exotic cars.'),
                        _buildFeatureItem('High-Fidelity Visuals', 'Experience cars through high-resolution imagery and cinematic presentations.'),
                        _buildFeatureItem('Real-Time Updates', 'Stay informed with the latest additions to the automotive world.'),
                        _buildFeatureItem('Interactive Comparison', 'Compare specs side-by-side to find the ultimate machine.'),
                        
                        const SizedBox(height: 60),
                        
                        // Footer / Copyright
                        Text(
                          '© 2025 GearGauge Team. All rights reserved.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.3),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFD5001C),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}

// Background Bubbles Painter
class BubblesBackground extends StatefulWidget {
  const BubblesBackground({super.key});

  @override
  State<BubblesBackground> createState() => _BubblesBackgroundState();
}

class _BubblesBackgroundState extends State<BubblesBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Bubble> _bubbles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Generate random bubbles
    for (int i = 0; i < 20; i++) {
      _bubbles.add(Bubble(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 50 + 20,
        speed: _random.nextDouble() * 0.05 + 0.01,
        opacity: _random.nextDouble() * 0.3 + 0.05,
        color: _random.nextBool() ? const Color(0xFFD5001C) : Colors.white,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BubblePainter(_bubbles, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class Bubble {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  Color color;

  Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.color,
  });
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final double animationValue;

  BubblePainter(this.bubbles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      // Move bubble up
      double currentY = bubble.y - (animationValue * bubble.speed * 5);
      // Wrap around
      if (currentY < -0.1) {
        currentY += 1.2; 
      }
      // Use modulo to keep it seamless if needed, but simple wrap is fine for this visual
      double drawY = (currentY % 1.2) * size.height;
      if (drawY > size.height) drawY -= size.height * 1.2;

      final paint = Paint()
        ..color = bubble.color.withOpacity(bubble.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(bubble.x * size.width, drawY),
        bubble.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
