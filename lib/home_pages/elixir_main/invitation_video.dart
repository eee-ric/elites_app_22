import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/invitation_video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class invitation_video extends StatefulWidget {
  const invitation_video({Key? key}) : super(key: key);

  @override
  State<invitation_video> createState() => _invitation_videoState();
}

class _invitation_videoState extends State<invitation_video> {
  List<InvitationVideoList> listInvitationVideoItems = [];
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('invitation_video_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((invitationVideoListFromJson) => InvitationVideoList(
            invitationVideo: invitationVideoListFromJson['invitation_video']))
        .toList();
    setState(() {
      listInvitationVideoItems = finalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ELIXIR'),
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
          itemCount: listInvitationVideoItems.length,
          itemBuilder: (BuildContext context, int index) {
            //onTAP FOR INDEX ITEMS
            InvitationVideoList invitationVideoListOrder =
                listInvitationVideoItems[index];
            return invitation_less(invitationVideoListOrder);
          },
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

    );
  }

  void open_browser_url({required Uri url, required bool inApp}) {}
}

class invitation_less extends StatelessWidget {
  InvitationVideoList invitationVideoList;

  invitation_less(this.invitationVideoList);

  @override
  Widget build(BuildContext context) {
    return invitation_full(invitationVideoList);
  }
}

class invitation_full extends StatefulWidget {
  InvitationVideoList invitationVideoList;

  invitation_full(this.invitationVideoList);

  @override
  State<invitation_full> createState() {
    return _invitation_fullState(invitationVideoList);
  }
}

class _invitation_fullState extends State<invitation_full> {
  final InvitationVideoList invitationVideoList;
  bool _fullScreen = false;
  late YoutubePlayerController _controller;

  _invitation_fullState(this.invitationVideoList);

  @override
  void initState() {
    final String videoURl = invitationVideoList.invitationVideo;
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
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: YoutubePlayerBuilder(
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
  void open_browser_url({required Uri url, required bool inApp}) async {
    if (await canLaunchUrl(url)) {
      await (launchUrl(url, mode: LaunchMode.externalApplication));
    }
  }
}
