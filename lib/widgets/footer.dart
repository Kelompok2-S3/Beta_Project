import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  final bool isActive;

  const Footer({super.key, required this.isActive});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          // 3-Column Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Column 1: About Us
              _buildFooterColumn(
                context,
                'About Us',
                [
                  _buildFooterLink(context, 'Our Story', () => context.go('/our-story')),
                  _buildFooterLink(context, 'Contact', () {}),
                  _buildFooterLink(context, 'Careers', () {}),
                  _buildFooterLink(context, 'Press', () {}),
                ],
              ),
              
              // Column 2: Services
              _buildFooterColumn(
                context,
                'Services',
                [
                  _buildFooterLink(context, 'Customer Login', () => context.go('/login')),
                  _buildFooterLink(context, 'Store', () {}),
                  _buildFooterLink(context, 'Find a Dealer', () {}),
                  _buildFooterLink(context, 'My Account', () {}),
                ],
              ),
              
              // Column 3: Community
              _buildFooterColumn(
                context,
                'Community',
                [
                  _buildFooterLink(context, 'Blog', () {}),
                  _buildFooterLink(context, 'Events', () {}),
                  _buildFooterLink(context, 'Forums', () {}),
                ],
              ),
            ],
          ).animate(target: isActive ? 1 : 0).fade(duration: 600.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 40),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),

          // Social Icons & Copyright
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _launchURL('https://www.facebook.com/KoenigseggAutomotiveAB'),
                    icon: const Icon(Icons.facebook, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () => _launchURL('https://www.instagram.com/koenigsegg'),
                    icon: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                '© 2024 Koenigsegg Automotive AB. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ).animate(target: isActive ? 1 : 0).fade(duration: 600.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
