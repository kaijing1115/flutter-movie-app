import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';

class PlayVideoFromVimeo extends StatefulWidget {
  const PlayVideoFromVimeo({Key? key, required this.videoKey})
      : super(key: key);

  final String videoKey;

  @override
  State<PlayVideoFromVimeo> createState() => _PlayVideoFromVimeoState();
}

class _PlayVideoFromVimeoState extends State<PlayVideoFromVimeo> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo(widget.videoKey),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller);
  }
}
