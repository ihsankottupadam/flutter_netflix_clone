import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPlayer extends StatefulWidget {
  const YtPlayer({Key? key, required this.videoId}) : super(key: key);
  final String videoId;

  @override
  State<YtPlayer> createState() => _YtPlayerState();
}

class _YtPlayerState extends State<YtPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
          autoPlay: false, loop: false, mute: false, enableCaption: false),
    )..setVolume(100);

    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Color(0x44ffffff)),
          progressIndicatorColor: Colors.red,
          topActions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        builder: (context, player) =>
            AspectRatio(aspectRatio: 9 / 16, child: player));
  }
}
