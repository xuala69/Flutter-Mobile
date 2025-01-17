import 'package:flutter/material.dart';
import 'package:prep_pro/controllers/protection_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ActualVideo extends StatefulWidget {
  final String link;
  const ActualVideo({required this.link, super.key});

  @override
  State<ActualVideo> createState() => _ActualVideoState();
}

class _ActualVideoState extends State<ActualVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    ProtectionController().to.secureApp();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _controller.toggleFullScreenMode();
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  void listener() {
    // if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
    //   setState(() {
    //     _playerState = _controller.value.playerState;
    //     _videoMetaData = _controller.metadata;
    //   });
    // }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    ProtectionController().to.unSecureApp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Column(
            children: [
              // some widgets
              player,
              //some other widgets
            ],
          );
        },
      ),
    );
  }
}
