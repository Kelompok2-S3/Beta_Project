import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPromoSection extends StatefulWidget {
  final bool isActive;
  final String videoPath;
  final String title;
  final String description;
  final String buttonText;

  const VideoPromoSection({
    super.key,
    required this.isActive,
    required this.videoPath,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  State<VideoPromoSection> createState() => _VideoPromoSectionState();
}

class _VideoPromoSectionState extends State<VideoPromoSection> {
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
    return Container(
      height: 500,
      color: Colors.black,
      child: Stack(
        children: [
          // --- Background Video ---
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),
          
          // --- Gradient Overlay ---
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // --- Content ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(widget.buttonText),
                ),
              ],
            ),
          ),

          // --- Tombol Suara ---
          Positioned(
            bottom: 20,
            right: 20,
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
    );
  }
}
