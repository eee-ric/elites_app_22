import 'package:cached_network_image/cached_network_image.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/top_left_list.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/top_left_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';
class layout_global_detail extends StatelessWidget {
  TopLeft topLeft;

  layout_global_detail(this.topLeft);

  @override
  Widget build(BuildContext context) {
    return LayoutGlobalFull(topLeft);
  }
}


class LayoutGlobalFull extends StatefulWidget {
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  final TopLeft topLeft;

  const LayoutGlobalFull(this.topLeft);

  @override
  State<LayoutGlobalFull> createState(){
   return _LayoutGlobalFullState(topLeft);
  }
}

class _LayoutGlobalFullState extends State<LayoutGlobalFull> {

  late final TopLeft topLeft;
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  _LayoutGlobalFullState(this.topLeft);

  @override
  void initState() {
    final String videoURl = topLeft.video;
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
          topLeft.title,
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
                imageUrl: topLeft.image),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: Text(
                topLeft.title.toUpperCase(),
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
              child: Text(topLeft.description,
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
