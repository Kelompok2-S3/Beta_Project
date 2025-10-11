import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

class CinematicHeroSection extends StatefulWidget {
  final double pageOffset;
  final String videoPath;

  const CinematicHeroSection({
    super.key,
    required this.pageOffset,
    required this.videoPath,
  });

  @override
  State<CinematicHeroSection> createState() => _CinematicHeroSectionState();
}

class _CinematicHeroSectionState extends State<CinematicHeroSection> {
  late VideoPlayerController _controller;
  bool _isMuted = true; // Video dimulai dalam keadaan senyap

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(_isMuted ? 0 : 1.0);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSound() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double contentOpacity = (1.0 - widget.pageOffset).clamp(0.0, 1.0);
    final double parallaxOffset = widget.pageOffset * -200;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        child: Stack(
          children: [
            // --- Background Video ---
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, parallaxOffset),
                child: _controller.value.isInitialized
                    ? SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _controller.value.size.width,
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),

            // --- Fading Content ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: contentOpacity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Experience Performance',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 10.0, color: Colors.black54)])
                        )
                        .animate()
                        .fade(duration: 1200.ms, delay: 300.ms)
                        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                        const SizedBox(height: 10),
                        const Text(
                          'Discover the new generation of premium vehicles.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18, shadows: [Shadow(blurRadius: 8.0, color: Colors.black54)])
                        )
                        .animate()
                        .fade(duration: 1200.ms, delay: 500.ms)
                        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                        const SizedBox(height: 60),
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
              ),
            ),

            // --- Tombol Suara ---
            Positioned(
              bottom: 30,
              right: 30,
              child: IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _toggleSound,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
