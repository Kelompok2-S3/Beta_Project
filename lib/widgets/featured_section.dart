import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'generic_card.dart';

class FeaturedSection extends StatelessWidget {
  final bool isActive;

  const FeaturedSection({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          )
          .animate(target: isActive ? 1 : 0)
          .fadeIn(duration: 900.ms, delay: 200.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

          const SizedBox(height: 40),

          LayoutBuilder(
            builder: (context, constraints) {
              // Use a column layout on narrow screens (e.g., mobile web)
              if (constraints.maxWidth < 768) {
                return Column(
                  children: [
                    const GenericCard(
                      title: 'Our Technology',
                      subtitle: 'Learn more',
                    )
                    .animate(target: isActive ? 1 : 0)
                    .fadeIn(duration: 900.ms, delay: 350.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

                    const SizedBox(height: 40),

                    const GenericCard(
                      title: 'Latest Designs',
                      subtitle: 'Explore now',
                    )
                    .animate(target: isActive ? 1 : 0)
                    .fadeIn(duration: 900.ms, delay: 500.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                  ],
                );
              }
              // Use a row layout on wider screens
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: GenericCard(
                      title: 'Our Technology',
                      subtitle: 'Learn more',
                    ),
                  )
                  .animate(target: isActive ? 1 : 0)
                  .fadeIn(duration: 900.ms, delay: 350.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

                  const SizedBox(width: 40),

                  const Expanded(
                    child: GenericCard(
                      title: 'Latest Designs',
                      subtitle: 'Explore now',
                    ),
                  )
                  .animate(target: isActive ? 1 : 0)
                  .fadeIn(duration: 900.ms, delay: 500.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
