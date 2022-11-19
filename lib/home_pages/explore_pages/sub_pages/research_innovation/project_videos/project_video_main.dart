import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/project_videos/project_video_list.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/project_videos/project_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../internship/internship_page.dart';

class project_video_main extends StatefulWidget {
  const project_video_main({Key? key}) : super(key: key);

  @override
  State<project_video_main> createState() => _project_video_mainState();
}

class _project_video_mainState extends State<project_video_main> {
  List<ProjectVideoList> listProjectVideoItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecordProjectVideo =
        await FirebaseFirestore.instance.collection('project_video_list').get();
    mapListRecord(ListRecordProjectVideo);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((projectVideoListFromJson) => ProjectVideoList(
            projectImage: projectVideoListFromJson['project_video_image'],
            projectVideo: projectVideoListFromJson['project_video'],
            projectName: projectVideoListFromJson['project_name'],
            projectDes: projectVideoListFromJson['project_description']))
        .toList();
    setState(() {
      listProjectVideoItems = finalList;
    });
  }
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Videos'),
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

          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: listProjectVideoItems.length,
              itemBuilder: (BuildContext context, int index) {
                ProjectVideoList projectVideoListOrder =
                    listProjectVideoItems[index];
                //onTAP FOR INDEX ITEMS
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => project_video_player(projectVideoListOrder)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //EXPLORE IMAGE
                        CachedNetworkImage(
                          imageUrl: listProjectVideoItems[index].projectImage,
                          imageBuilder: (context, imageProvider) => Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 150,
                            decoration: BoxDecoration(
                              boxShadow:  [
                                BoxShadow(color: blue, blurRadius: 10)
                              ],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fitHeight,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.colorBurn)),
                            ),
                          ),
                        ),
                        Container(
                          height: 150,
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: blue, blurRadius: 10)
                            ],
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listProjectVideoItems[index].projectName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.secularOne(
                                  fontSize: 22,
                                  color: blue,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
