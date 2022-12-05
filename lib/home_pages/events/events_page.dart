import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/events/event_list.dart';
import 'package:elites_app_22/home_pages/events/route_for_events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class events_page extends StatefulWidget {
  const events_page({Key? key}) : super(key: key);

  @override
  State<events_page> createState() => _events_pageState();
}

class _events_pageState extends State<events_page> {
  List<EventList> listEventItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('events_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((eventListFromJson) => EventList(
              eventPoster: eventListFromJson['event_poster'],
              eventTitle: eventListFromJson['event_title'],
              eventStatus: eventListFromJson['event_status'],
              eventDate: eventListFromJson['event_date'],
              eventVenue: eventListFromJson['event_venue'],
              eventContact: eventListFromJson['event_contact'],
              eventDescription: eventListFromJson['event_description'],
            ))
        .toList();
    setState(() {
      listEventItems = finalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
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
        itemCount: listEventItems.length,
        itemBuilder: (BuildContext context, int index) {
          EventList eventListOrder = listEventItems[index];
          var color = Colors.white;
          String redEnable = "INNACTIVE";
          String greenEnable = "ACTIVE";
          if (listEventItems[index].eventStatus.toUpperCase() == redEnable) {
            color = Colors.red;
          } else if (listEventItems[index].eventStatus.toUpperCase() ==
              greenEnable) {
            color = Colors.green;
          }
          //onTAP FOR INDEX ITEMS
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>route_events(eventListOrder)));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.39,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: blueBg,
                  // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.06,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                   const EdgeInsets.symmetric(horizontal: 10.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    listEventItems[index].eventTitle,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.secularOne(),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius, color: blue),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Padding(
                                  padding:  const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height*0.02,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        "Status : ${listEventItems[index].eventStatus.toUpperCase()}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.secularOne(
                                             color: color),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //EXPLORE IMAGE
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CachedNetworkImage(
                        imageUrl: listEventItems[index].eventPoster,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.25,
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  'Date : ${listEventItems[index].eventDate}',
                                  textAlign: TextAlign.center,

                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  'Venue : ${listEventItems[index].eventVenue.toUpperCase()}',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
