import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPromoSection extends StatefulWidget {
  final bool isActive;
  final String? videoPath;
  final String? imagePath; // Added imagePath
  final String title;
  final String description;
  final String buttonText;

  const VideoPromoSection({
    super.key,
    required this.isActive,
    this.videoPath,
    this.imagePath, // Added to constructor
    required this.title,
    required this.description,
    required this.buttonText,
  }) : assert(videoPath != null || imagePath != null, 'Either videoPath or imagePath must be provided.');

  @override
  State<VideoPromoSection> createState() => _VideoPromoSectionState();
}

class _VideoPromoSectionState extends State<VideoPromoSection> {
  VideoPlayerController? _controller; // Made nullable
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    if (widget.videoPath != null) { // Conditional initialization
      _controller = VideoPlayerController.asset(widget.videoPath!)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            _controller?.play();
            _controller?.setLooping(true);
            _controller?.setVolume(_isMuted ? 0 : 1.0);
          }
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose only if it exists
    super.dispose();
  }

  void _toggleSound() {
    if (_controller == null) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand, // Ensure children fill the stack
        children: [
          // --- Background ---
          if (widget.imagePath != null)
            Image.asset(
              widget.imagePath!,
              fit: BoxFit.cover,
            )
          else if (_controller != null && _controller!.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
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
                  Colors.black.withAlpha((0.7 * 255).round()),
                  Colors.transparent,
                  Colors.black.withAlpha((0.7 * 255).round()),
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

          // --- Tombol Suara (Sound Button) ---
          if (widget.videoPath != null) // Only show for videos
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
