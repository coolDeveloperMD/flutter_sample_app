import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerViewWidget extends StatefulWidget {
  final String url;

  const YouTubePlayerViewWidget({super.key, required this.url});

  @override
  State<YouTubePlayerViewWidget> createState() =>
      _YouTubePlayerViewWidgetState();
}

class _YouTubePlayerViewWidgetState extends State<YouTubePlayerViewWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String? videoID = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
      ],
    );
  }
}
