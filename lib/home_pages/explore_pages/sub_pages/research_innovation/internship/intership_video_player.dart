import 'dart:developer';

import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/internship_page.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/intership_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class internship_video_player extends StatelessWidget {
  InternshipList internshipList;

  internship_video_player(this.internshipList);

  @override
  Widget build(BuildContext context) {
    return video_body(internshipList);
  }
}

class video_body extends StatefulWidget {
  final blue = const Color.fromRGBO(0, 0, 153, 30);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(255, 216, 0, 50);
  final InternshipList internshipList;

  const video_body(this.internshipList);

  @override
  State<video_body> createState() {
    return _video_bodyState(internshipList);
  }
}

class _video_bodyState extends State<video_body> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final String videoURl = internshipList.internshipVideo;
    final videoID = YoutubePlayer.convertUrlToId(videoURl);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(autoPlay: false, loop: true),
    )..addListener(listener);

    // TODO: implement initState
    super.initState();
  }

  late final InternshipList internshipList;
  bool _fullScreen = false;

  _video_bodyState(this.internshipList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _fullScreen
          ? null
          : AppBar(
              title: Text(internshipList.internshipStep),
              backgroundColor: blue,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
            ),
      body:YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: blue,
          progressColors:  ProgressBarColors(
            playedColor: blue,
            handleColor: blueBg,
          ),
          onReady: () {
            _controller.addListener(() {});
          },
        ),
        builder: (context, player) => player,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void listener() {
    setState(() {
      _fullScreen = _controller.value.isFullScreen;
    });
  }
}
