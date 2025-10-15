// lib/presentation/widgets/youtube_player_widget.dart

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String videoId;
  final bool autoPlay;
  final VoidCallback? onEnded;

  const YouTubePlayerWidget({
    super.key,
    required this.videoId,
    this.autoPlay = false,
    this.onEnded,
  });

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      params: YoutubePlayerParams(
        showControls: true,
        mute: false,
        enableCaption: true,
        showFullscreenButton: true,
        playsInline: true,
      ),
    );

    // Detect end of video
    _controller.listen((value) {
      if (value.playerState == PlayerState.ended) {
        widget.onEnded?.call();
      }
    });
    if (widget.autoPlay) {
      // Defer to ensure the controller is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.playVideo();
      });
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller, aspectRatio: 16 / 9);
  }
}
