import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppFooter extends StatelessWidget {
  final bool isActive;

  const AppFooter({super.key, required this.isActive});

  // Helper widget for a single column of links
  Widget _buildLinkColumn(String title, List<String> links) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
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
          const SizedBox(height: 15),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              link,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List of link columns to avoid repetition
    final List<Widget> linkColumns = [
      _buildLinkColumn('About Us', ['Our Story', 'Contact', 'Careers', 'Press'])
          .animate(target: isActive ? 1 : 0)
          .fadeIn(duration: 900.ms, delay: 200.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
      _buildLinkColumn('Services', ['Customer Login', 'Store', 'Find a Dealer', 'My Account'])
          .animate(target: isActive ? 1 : 0)
          .fadeIn(duration: 900.ms, delay: 350.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
      _buildLinkColumn('Community', ['Blog', 'Events', 'Forums'])
          .animate(target: isActive ? 1 : 0)
          .fadeIn(duration: 900.ms, delay: 500.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
    ];

    return Container(
      color: const Color(0xFF191919), // Dark grey background
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  // Use a column on narrow screens
                  if (constraints.maxWidth < 768) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: linkColumns,
                    );
                  }
                  // Use a row on wider screens
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: linkColumns,
                  );
                },
              ),
              const SizedBox(height: 40),
              const Divider(color: Colors.white24, indent: 40, endIndent: 40),
              const SizedBox(height: 20),
              const Text(
                '© 2024 Your Company. All rights reserved.',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              )
              .animate(target: isActive ? 1 : 0)
              .fadeIn(duration: 900.ms, delay: 650.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}
