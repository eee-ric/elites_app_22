//    FIRE STORE Variables in this page
//
//                                    facilities_front_title
//      facilities_list   --------  = facilities_front_image
//                                    facilities_detail

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/facilities/route_for_facilitiesItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'facilities_list.dart';

class facilities extends StatefulWidget {
  const facilities({Key? key}) : super(key: key);

  @override
  State<facilities> createState() => _facilitiesState();
}

class _facilitiesState extends State<facilities> {
  List<FacilitiesList> listFacilitiesItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecordFacilities =
        await FirebaseFirestore.instance.collection('facilities_list').get();
    mapListRecord(ListRecordFacilities);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var final_list = ListRecord.docs
        .map((facilitiesListFromJson) => FacilitiesList(
            facilitiesFrontImage:
                facilitiesListFromJson['facilities_front_image'],
            facilitiesFrontTitle:
                facilitiesListFromJson['facilities_front_title'],
            facilitiesDetailText: facilitiesListFromJson['facilities_detail'], facilitiesSpaceDetail: facilitiesListFromJson['facilities_space_detail']))
        .toList();
    setState(() {
      listFacilitiesItems = final_list;
    });
  }
  final blue = const Color.fromRGBO(0, 0, 153, 30);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(255, 216, 0, 50);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Facilities'),
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
          itemCount: listFacilitiesItems.length,
          itemBuilder: (BuildContext context, int index) {
            FacilitiesList facilitiesListOrder = listFacilitiesItems[index];
            //onTAP FOR INDEX ITEMS
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            route_for_facilities(facilitiesListOrder)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //EXPLORE IMAGE
                  CachedNetworkImage(
                    imageUrl: listFacilitiesItems[index].facilitiesFrontImage,
                    imageBuilder: (context, imageProvider) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(

                          borderRadius: borderRadius,
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //FACILITIES TITLE
                            Container(
                              decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: yellow,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Text(
                                    listFacilitiesItems[index]
                                        .facilitiesFrontTitle,
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
                                    listFacilitiesItems[index]
                                        .facilitiesSpaceDetail,
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
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
