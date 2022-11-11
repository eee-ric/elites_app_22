import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_main_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class elixir_main_page extends StatefulWidget {
  const elixir_main_page({Key? key}) : super(key: key);

  @override
  State<elixir_main_page> createState() => _elixir_main_pageState();
}

class _elixir_main_pageState extends State<elixir_main_page> {
  List<ElixirMainEventList> listElixirEventItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord = await FirebaseFirestore.instance
        .collection('elixir_main_event_list')
        .get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var final_list = ListRecord.docs
        .map((elixirMainEventListFromJson) => ElixirMainEventList(
            elixirMainEventImage: elixirMainEventListFromJson['elixir_event_image'],
            elixirMainEventTitle: elixirMainEventListFromJson['elixir_event_title'],
            elixirMainEventVenue: elixirMainEventListFromJson['elixir_event_venue'],
            elixirMainEventTime: elixirMainEventListFromJson['elixir_event_time'],
            elixirMainEventDescription:
            elixirMainEventListFromJson['elixir_event_description'],
            elixirMainEventContact:
            elixirMainEventListFromJson['elixir_event_contact']))
        .toList();
    setState(() {
      listElixirEventItems = final_list;
    });
  }

  final logoRed = const Color.fromRGBO(103, 0, 1, 20);
  final CardBG = const Color.fromRGBO(242, 240, 197, 86);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ELIXIR'),
        backgroundColor: const Color.fromRGBO(103, 0, 1, 20),
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
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    'Events :',
                    style: GoogleFonts.secularOne(fontSize: 20),
                  ),
                ),
                ListView.builder(
                  itemCount: listElixirEventItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    ElixirMainEventList elixirEventListOrder =
                        listElixirEventItems[index];
                    return CachedNetworkImage(
                      imageUrl:
                          listElixirEventItems[index].elixirMainEventImage,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
