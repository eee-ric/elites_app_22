import 'package:cached_network_image/cached_network_image.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_project_lists.dart';
import 'package:elites_app_22/home_pages/elixir_main/ric_project_list/ric_pro_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';


class elixir_project_ extends StatelessWidget {
  RicProjectList elixirProjectList;

  elixir_project_(this.elixirProjectList);

  @override
  Widget build(BuildContext context) {
    return elixir_project_full(elixirProjectList);
  }
}

class elixir_project_full extends StatefulWidget {
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  final RicProjectList elixirProjectList;

  const elixir_project_full(this.elixirProjectList);

  @override
  State<elixir_project_full> createState() {
    return _elixir_project_fullState(elixirProjectList);
  }
}

class _elixir_project_fullState extends State<elixir_project_full> {
  late final RicProjectList elixirProjectList;
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  _elixir_project_fullState(this.elixirProjectList);

  @override
  void initState() {
    final String videoURl = elixirProjectList.elixirProjectListVideo;
    final videoID = YoutubePlayer.convertUrlToId(videoURl);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(autoPlay: false, loop: true),
    )..addListener(listener);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _fullScreen
          ? null
          : AppBar(
        title: Text(
          elixirProjectList.elixirProjectListName,
          style: const TextStyle(overflow: TextOverflow.fade),
        ),
        backgroundColor: blue,
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
          Center(
            child: CachedNetworkImage(
                imageUrl: elixirProjectList.elixirProjectListImage),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: Text(
                elixirProjectList.elixirProjectListName.toUpperCase(),
                style: GoogleFonts.secularOne(fontSize: 24, color: blue),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Divider(
              height: 1,
              color: blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: Text(elixirProjectList.elixirProjectListDescription,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.alegreya(
                      color: blue, fontSize: 18, fontWeight: FontWeight.w500)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Divider(
              height: 1,
              color: blue,
            ),
          ),
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: blue,
              progressColors: const ProgressBarColors(
                playedColor: blue,
                handleColor: blueBg,
              ),
              onReady: () {
                _controller.addListener(() {});
              },
            ),
            builder: (context, player) => player,
          ),
        ],
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
