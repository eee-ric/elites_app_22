import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/project_videos/project_video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../internship/internship_page.dart';

class project_video_player extends StatefulWidget {
  final ProjectVideoList projectVideoList;

  const project_video_player(this.projectVideoList);

  @override
  State<project_video_player> createState() {
    return _project_video_playerState(projectVideoList);
  }
}

class _project_video_playerState extends State<project_video_player> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final String videoURl = projectVideoList.projectVideo;
    final videoID = YoutubePlayer.convertUrlToId(videoURl);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(autoPlay: false, loop: true),
    )..addListener(listener);

    // TODO: implement initState
    super.initState();
  }

  late final ProjectVideoList projectVideoList;
  bool _fullScreen = false;

  _project_video_playerState(this.projectVideoList);

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: blue,
        progressColors:  ProgressBarColors(
          playedColor: blue,
          handleColor: Color.fromRGBO(135, 0, 0, 27),
        ),
        onReady: () {
          _controller.addListener(() {});
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: _fullScreen
            ? null
            : AppBar(
                title: Text(projectVideoList.projectName),
                backgroundColor: const Color.fromRGBO(103, 0, 1, 20),
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 10, right: 10),
              child: Text(
                projectVideoList.projectDes,
                style: GoogleFonts.alegreya(fontSize: 18, color: blue),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
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
