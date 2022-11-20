import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/notify/notify_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class notify_main extends StatefulWidget {
  const notify_main({Key? key}) : super(key: key);

  @override
  State<notify_main> createState() => _notify_mainState();
}

class _notify_mainState extends State<notify_main> {
  List<Notify> listExploreItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('notification_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((notifyListFromJson) => Notify(
            notifyName: notifyListFromJson['notify_name'],
            notifyDescription1: notifyListFromJson['notify_description1'],
            notifyDescription2: notifyListFromJson['notify_description2']))
        .toList();
    setState(() {
      listExploreItems = finalList;
    });
  }

  final blue = const Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253, 185, 19, 50);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
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
        itemCount: listExploreItems.length,
        itemBuilder: (BuildContext context, int index) {
          //onTAP FOR INDEX ITEMS
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: blueBg,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: borderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      listExploreItems[index].notifyName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 10),
                    child: Text(
                      listExploreItems[index].notifyDescription1,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 20),
                    child: Text(
                      listExploreItems[index].notifyDescription2,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
