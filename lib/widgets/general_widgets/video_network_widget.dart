import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/pause_and_play.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NetworkVideoWidget extends StatefulWidget {
  final Uri videoUrl;
  final double height;
  final double radius;
  final double width;
  final bool showPauseIcon;
  final String image;
  const NetworkVideoWidget(
      {super.key,
      required this.videoUrl,
      this.height = 300,
      this.radius = 15,
      this.width = 0,
      this.showPauseIcon = false,
      required this.image});

  @override
  State<NetworkVideoWidget> createState() => _NetworkVideoWidgetState();
}

class _NetworkVideoWidgetState extends State<NetworkVideoWidget>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  bool get wantKeepAlive => true; // Keeps widget alive even when scrolling

  @override
  void initState() {
    super.initState();
    _initializeVideoController();
  }

  Future<void> _initializeVideoController() async {
    _controller = VideoPlayerController.networkUrl(widget.videoUrl);

    // Wait for initialization to complete
    await _controller.initialize();

    // Set looping
    await _controller.setLooping(true);

    // Set volume (optional - to avoid multiple audios playing)
    await _controller.setVolume(1.0);

    // Only if widget is still mounted, update state and play
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVisibility(double visibilityFraction) {
    if (visibilityFraction == 1) {
      setState(() {
        _controller.play();
      });
    } else {
      setState(() {
        _controller.pause();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed when using AutomaticKeepAliveClientMixin
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
                child: _isInitialized
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : CachedImage(
                        image: widget.image,
                        height: widget.height,
                        width: width,
                        radius: widget.radius,
                      )),
            // Optional: Add play/pause controls
            if (_isInitialized && widget.showPauseIcon)
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: PauseAndPlay(
                      isPlaying: _controller.value.isPlaying,
                      action: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      })),
          ],
        ),
      ),
    );
  }
}
