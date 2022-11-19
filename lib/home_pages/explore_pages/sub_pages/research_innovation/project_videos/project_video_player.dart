import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/project_videos/project_video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
    const blue = Color.fromRGBO(46, 49, 146, 38);
    const blueBg = Color.fromRGBO(149, 157, 244, 77);
    const yellow = Color.fromRGBO(253,185,19, 50);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: blue,
        progressColors:  const ProgressBarColors(
          playedColor: blue,
          handleColor: blueBg,
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
                backgroundColor:blue,
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 90,
            decoration: const BoxDecoration(
                color: yellow
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                          "https://www.instagram.com/eee_nmamit/");
                      open_browser_url(url: url, inApp: true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FaIcon(FontAwesomeIcons.instagram),
                        Text(
                          "eee_nmamit",
                          style: GoogleFonts.secularOne(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                          "https://www.linkedin.com/in/electrical-and-electronics-engineering-316a62176/");
                      open_browser_url(url: url, inApp: true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FaIcon(FontAwesomeIcons.linkedin),
                        Text(
                          "EEE NMAMIT",
                          style: GoogleFonts.secularOne(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                          "https://www.youtube.com/channel/UC7ve97BbEy44KPFca2FgxJg");
                      open_browser_url(url: url, inApp: true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FaIcon(FontAwesomeIcons.youtube),
                        Text(
                          "Elites NMAMIT",
                          style: GoogleFonts.secularOne(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
  void open_browser_url({required Uri url, required bool inApp}) async {
    if (await canLaunchUrl(url)) {
      await (launchUrl(url, mode: LaunchMode.externalApplication));
    }
  }
}
