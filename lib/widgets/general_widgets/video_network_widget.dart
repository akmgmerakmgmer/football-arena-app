import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NetworkVideoWidget extends StatefulWidget {
  final Uri videoUrl;
  final double? height;
  final double radius;
  final double width;
  const NetworkVideoWidget({
    super.key,
    required this.videoUrl,
    this.height = 300,
    this.radius = 15,
    this.width = 0,
  });

  @override
  State<NetworkVideoWidget> createState() => _NetworkVideoWidgetState();
}

class _NetworkVideoWidgetState extends State<NetworkVideoWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Update UI when video is ready
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVisibility(double visibilityFraction) {
    if (visibilityFraction > 0.5) {
      if (!_controller.value.isPlaying) {
        _controller.play();
        setState(() => _isPlaying = true);
      }
    } else {
      if (_controller.value.isPlaying) {
        _controller.pause();
        setState(() => _isPlaying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width =
        widget.width != 0 ? widget.width : MediaQuery.of(context).size.width;
    return VisibilityDetector(
      key: Key(widget.videoUrl.toString()),
      onVisibilityChanged: (visibilityInfo) {
        _handleVisibility(visibilityInfo.visibleFraction);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: widget.height,
              width: width,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                    _isPlaying ? _controller.play() : _controller.pause();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
