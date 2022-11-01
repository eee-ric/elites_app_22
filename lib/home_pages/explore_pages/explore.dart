//  FIRESTORE VARIABLES
//
//           explore_list    =      explore_image
//                                  explore_title
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_main_page.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/facilities/facilities.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/funding/funding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'explore list.dart';

class explore extends StatefulWidget {
  const explore({Key? key}) : super(key: key);

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  List<ExploreList> listExploreItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('explore_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((exploreListFromJson) => ExploreList(
            exploreImage: exploreListFromJson['explore_image'],
            exploreTitle: exploreListFromJson['explore_title']))
        .toList();
    setState(() {
      listExploreItems = finalList;
    });
  }

  final logoRed = const Color.fromRGBO(103, 0, 1, 20);
  final logoRedCardBG = const Color.fromRGBO(242, 240, 197, 86);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Explore'),
          backgroundColor: const Color.fromRGBO(103, 0, 1, 20),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: listExploreItems.length,
          itemBuilder: (BuildContext context, int index) {
            //onTAP FOR INDEX ITEMS
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const facilities()));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const funding_page()));
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const elites_main_page()));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: Colors.black12,
                      // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
            ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //EXPLORE IMAGE
                      CachedNetworkImage(
                        imageUrl: listExploreItems[index].exploreImage,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width * .35,
                          height: 120,
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   new BoxShadow(color: logoRed, blurRadius: 5)
                            // ],
                            borderRadius: borderRadius,
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.colorBurn)),
                          ),
                        ),
                      ),

                      //EXPLORE TITLE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            listExploreItems[index].exploreTitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.secularOne(fontSize: 22),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
