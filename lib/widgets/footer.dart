import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animate the icon row individually
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _launchURL('https://www.facebook.com/KoenigseggAutomotiveAB'),
                  icon: const Icon(Icons.facebook, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () => _launchURL('https://www.instagram.com/koenigsegg'),
                  icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
                ),
              ],
            )
            .animate(target: isActive ? 1 : 0)
            .fade(duration: 900.ms, delay: 200.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

            const SizedBox(height: 30),

            // Animate the copyright text individually with a delay
            const Text(
              '© 2024 Koenigsegg Automotive AB. All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            )
            .animate(target: isActive ? 1 : 0)
            .fade(duration: 900.ms, delay: 350.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }
}
