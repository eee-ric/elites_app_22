import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/home_page.dart';
import 'package:elites_app_22/home_pages/main_video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'home_pages/explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class main_video extends StatefulWidget {
  const main_video({Key? key}) : super(key: key);

  @override
  State<main_video> createState() => _main_videoState();
}

class _main_videoState extends State<main_video> {
  List<TeaserVideoLink> listTeaserVideoItems = [];
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('teaser_video').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((videoLinkFromJson) =>
            TeaserVideoLink(teaserVideoLink: videoLinkFromJson['video_link']))
        .toList();
    setState(() {
      listTeaserVideoItems = finalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listTeaserVideoItems.length,
            itemBuilder: (BuildContext context, int index) {
              TeaserVideoLink teaserVideoOrder = listTeaserVideoItems[index];
              return teaser_video_less(teaserVideoOrder);
            }),
      ),
    );
  }
}

class teaser_video_less extends StatelessWidget {
  TeaserVideoLink teaserVideoLink;

  teaser_video_less(this.teaserVideoLink);

  @override
  Widget build(BuildContext context) {
    return tease_video_full(teaserVideoLink);
  }
}

class tease_video_full extends StatefulWidget {
  TeaserVideoLink teaserVideoLink;

  tease_video_full(this.teaserVideoLink);

  @override
  State<tease_video_full> createState() {
    return _tease_video_fullState(teaserVideoLink);
  }
}

class _tease_video_fullState extends State<tease_video_full> {
  final TeaserVideoLink teaserVideoLink;
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  _tease_video_fullState(this.teaserVideoLink);

  @override
  void initState() {
    final String videoURl = teaserVideoLink.teaserVideoLink;
    final videoID = YoutubePlayer.convertUrlToId(videoURl);
    bool _fullScreen = false;
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(autoPlay: true, loop: true),
    )..addListener(listener);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            bottomActions: const [],
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          builder: (context, player) => player,
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                // If the video is paused, play it.
                _controller.play();
              }
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('SKIP',style: TextStyle(color: blue),),
                ),
                FaIcon(Icons.skip_next,color: blue,),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        )
      ],
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
