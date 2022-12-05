import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_project_detail.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_project_lists.dart';
import 'package:elites_app_22/home_pages/elixir_main/ric_project_list/ric_pro_list.dart';
import 'package:elites_app_22/home_pages/elixir_main/ric_project_list/ric_project_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class ric_project extends StatefulWidget {
  const ric_project({Key? key}) : super(key: key);

  @override
  State<ric_project> createState() => _ric_projectState();
}

class _ric_projectState extends State<ric_project> {
  List<RicProjectList> listElixirProjectItems = [];
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord = await FirebaseFirestore.instance
        .collection('ric_project_list')
        .get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((ricProjectListFromJson) => RicProjectList(
        elixirProjectListImage:
        ricProjectListFromJson['ric_project_image'],
        elixirProjectListName:
        ricProjectListFromJson['ric_project_name'],
        elixirProjectListDescription:
        ricProjectListFromJson['ric_project_description'],
        elixirProjectListVideo:
        ricProjectListFromJson['ric_project_video']))
        .toList();
    setState(() {
      listElixirProjectItems = finalList;
    });
  }

  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('RIC Projects'),
          backgroundColor: blue,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: listElixirProjectItems.length,
          itemBuilder: (BuildContext context, int index) {
            //onTAP FOR INDEX ITEMS
            RicProjectList elixirProjectListOrder =
            listElixirProjectItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            elixir_project_(elixirProjectListOrder)));
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller.play();
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: blueBg,
                    // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: Text(
                                listElixirProjectItems[index]
                                    .elixirProjectListName
                                    .toUpperCase(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.secularOne(fontSize: 22),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: (Text(
                                  'Know More',
                                  style: GoogleFonts.secularOne(
                                      fontSize: 18, color: Colors.white),
                                )),
                              ),
                            ),
                          ),

                        ],
                      ),
                      elixir_project_Video(elixirProjectListOrder),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class elixir_project_Video extends StatelessWidget {
  RicProjectList elixirProjectList;

  elixir_project_Video(this.elixirProjectList);

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
      flags: const YoutubePlayerFlags(autoPlay: true, loop: true),
    )..addListener(listener);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            bottomActions: [
              const SizedBox(width: 14.0),
              CurrentPosition(),
              const SizedBox(width: 8.0),
              ProgressBar(),
              RemainingDuration(),
              const PlaybackSpeedButton(),
            ],
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          builder: (context, player) => player,
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
