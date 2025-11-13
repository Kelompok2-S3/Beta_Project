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

class _CinematicHeroSectionState extends State<CinematicHeroSection> with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _isMuted = true; // Kembali menggunakan state lokal

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.play();
          _controller.setLooping(true);
          _controller.setVolume(_isMuted ? 0 : 1.0);
        }
      });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) return;

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    final bool isVisible = ModalRoute.of(context)?.isCurrent ?? false;
    if (isVisible) {
      if (_controller.value.isInitialized && !_controller.value.isPlaying) {
        _controller.play();
      }
    } else {
      if (_controller.value.isInitialized && _controller.value.isPlaying) {
        _controller.pause();
      }
    }

    final double contentOpacity = (1.0 - widget.pageOffset).clamp(0.0, 1.0);
    final double parallaxOffset = widget.pageOffset * -200;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        child: Stack(
          children: [
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
                        Text(
                          'Experience Performance',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ).animate().fade(duration: 1200.ms, delay: 300.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                        const SizedBox(height: 10),
                        Text(
                          'Discover the new generation of premium vehicles.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).animate().fade(duration: 1200.ms, delay: 500.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                        const SizedBox(height: 60),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.white,
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).slideY(duration: 1800.ms, begin: 0, end: 0.4, curve: Curves.easeInOut),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _toggleSound, // Kembali menggunakan _toggleSound
              ),
            ),
          ],
        ),
      ),
    );
  }
}
