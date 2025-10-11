import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

class HeroSection extends StatefulWidget {
  // This is the crucial input: the precise scroll position from the PageView (0.0 to N)
  final double pageOffset;

  const HeroSection({super.key, required this.pageOffset});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // Using the correct Koenigsegg video URL
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://www.koenigsegg.com/wp-content/uploads/2020/03/Koenigsegg-Gemera-reveal-low-res.mp4'),
    )..initialize().then((_) {
      setState(() {});
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      _videoPlayerController.setVolume(0.0);
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the opacity for the fade-out effect based on the transition
    // from page 0 to page 1. It will be 1.0 at page 0 and 0.0 at page 1.
    final double contentOpacity = (1.0 - widget.pageOffset).clamp(0.0, 1.0);

    // Calculate the parallax offset for the video. The video will move up
    // as the user scrolls down, creating the depth effect.
    final double parallaxOffset = widget.pageOffset * -200; // Move video up by 200px during transition

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        child: Stack(
          children: [
            // 1. Parallax Video Background
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, parallaxOffset),
                child: _videoPlayerController.value.isInitialized
                    ? SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoPlayerController.value.size.width,
                            height: _videoPlayerController.value.size.height,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                      )
                    : Container(color: Colors.black),
              ),
            ),

            // 2. Fading Content Overlay
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: contentOpacity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // The initial entry animation for the text
                    const Column(
                      children: [
                        Text('JESCO ABSOLUT', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold, letterSpacing: 5, shadows: [Shadow(blurRadius: 10.0, color: Colors.black54)])),
                        SizedBox(height: 10),
                        Text('THE FASTEST KOENIGSEGG EVER. FOREVER.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, shadows: [Shadow(blurRadius: 8.0, color: Colors.black54)])),
                      ],
                    )
                    .animate()
                    .fade(duration: 1200.ms, delay: 300.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),

                    const SizedBox(height: 60),

                    // The looping scroll indicator animation
                    Container(
                      height: 50,
                      width: 2,
                      color: Colors.white,
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .slideY(duration: 1800.ms, begin: 0, end: 0.4, curve: Curves.easeInOut),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
