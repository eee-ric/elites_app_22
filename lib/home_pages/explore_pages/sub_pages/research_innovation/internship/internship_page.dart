import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/intership_list.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/intership_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class internship_page extends StatefulWidget {
  const internship_page({Key? key}) : super(key: key);

  @override
  State<internship_page> createState() => _internship_pageState();
}


const blue = Color.fromRGBO(46, 49, 146, 38);
const blueBg = Color.fromRGBO(149, 157, 244, 77);
const yellow = Color.fromRGBO(253,185,19, 50);
final borderRadius = BorderRadius.circular(25);

class _internship_pageState extends State<internship_page> {
  List<InternshipList> listInternshipItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecordIntership =
        await FirebaseFirestore.instance.collection('internship_list').get();
    mapListRecord(ListRecordIntership);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((internshipListFromJson) => InternshipList(
            internshipImage: internshipListFromJson['internship_image'],
            internshipVideo: internshipListFromJson['internship_video'],
            internshipStep: internshipListFromJson['internship_step'],
            internshipStepDes: internshipListFromJson['internship_step_des']))
        .toList();
    setState(() {
      listInternshipItems = finalList;
    });
  }

  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship'),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '\t \t   Center for Design of Power Electronic Systems offers two months summer internship for interested students of the college.'
              ' The intention of the internship is to develop the technical and soft skills in students to make them industry ready. '
              'Students undergo three weeks of training to get acquainted with theory, simulation, embedded coding, OrCAD schematic, and layout tools required to develop industry products.'
              ' After the completion of training, students work on live Power Electronics projects under the guidance of faculty. '
              '\n\n\t\tAfter the completion of the Internship, 2-3 years of dedication from the students will lead to career opportunities in the field of Power Electronic Systems.',
              style: GoogleFonts.alegreya(
                  fontSize: 18, color: blue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: listInternshipItems.length,
              itemBuilder: (BuildContext context, int index) {
                InternshipList internshipListOrder = listInternshipItems[index];
                //onTAP FOR INDEX ITEMS
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  internship_video_player(internshipListOrder)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //EXPLORE IMAGE
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CachedNetworkImage(
                            imageUrl: listInternshipItems[index].internshipImage,
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 150,
                              decoration: BoxDecoration(

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
                        ),
                        Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Color.fromRGBO(255, 179, 0, 50)
                          ),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listInternshipItems[index].internshipStep,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.secularOne(
                                  fontSize: 22,
                                  color: blue,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                              ),
                              Text(
                                listInternshipItems[index].internshipStepDes,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 18,
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
