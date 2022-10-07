import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                facilitiesListFromJson['facilities_front_title']))
        .toList();
    setState(() {
      listFacilitiesItems = final_list;
    });
  }

  final logoRed = Color.fromRGBO(103, 0, 1, 20);
  final CardBG = Color.fromRGBO(242, 240, 197, 86);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Facilities'),
          backgroundColor: Color.fromRGBO(103, 0, 1, 20),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: listFacilitiesItems.length,
          itemBuilder: (BuildContext context, int index) {
            //onTAP FOR INDEX ITEMS
            return Column(
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
                        // boxShadow: [
                        //   new BoxShadow(color: logoRed, blurRadius: 5)
                        // ],
                        borderRadius: borderRadius,
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //FACILITIES TITLE
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CardBG,
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
                                      color: logoRed,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,
                                  ),

                                  Text(
                                    listFacilitiesItems[index]
                                        .facilitiesFrontTitle,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.secularOne(
                                      fontSize: 22,
                                      color: logoRed,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
