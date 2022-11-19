import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'elixir_main_event_list.dart';

class elixir_event_detail extends StatefulWidget {
  const elixir_event_detail({Key? key}) : super(key: key);

  @override
  State<elixir_event_detail> createState() => _elixir_event_detailState();
}

class _elixir_event_detailState extends State<elixir_event_detail> {
  List<ElixirMainEventList> listElixirEventItems = [];

  @override
  void initState() {
    queryDb();
    super.initState();
  }

  late Stream slides;
  int activeIndex = 0;
  bool isInitialized = false;

  Stream queryDb() {
    slides = FirebaseFirestore.instance
        .collection('elixir_main_event_list')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }

  Future readData() async {
    final QuerySnapshot result = (await FirebaseFirestore.instance
            .collection('elixir_main_event_list')
            .snapshots()
            .map((list) => list.docs.map((doc) => doc.data())))
        as QuerySnapshot<Object?>;
    final List<DocumentSnapshot> list = result.docs;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('elixir_main_event_list', <String>[
      'elixir_event_image',
      'elixir_event_title',
      'elixir_event_venue',
      'elixir_event_time',
      'elixir_event_description',
      'elixir_event_contact'
    ]);
    final List<String>? items = prefs.getStringList('elixir_main_event_list');
  }

  final CarouselController controller = CarouselController();

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var final_list = ListRecord.docs
        .map((elixirMainEventListFromJson) => ElixirMainEventList(
            elixirMainEventImage:
                elixirMainEventListFromJson['elixir_event_image'],
            elixirMainEventTitle:
                elixirMainEventListFromJson['elixir_event_title'],
            elixirMainEventVenue:
                elixirMainEventListFromJson['elixir_event_venue'],
            elixirMainEventTime:
                elixirMainEventListFromJson['elixir_event_time'],
            elixirMainEventDescription:
                elixirMainEventListFromJson['elixir_event_description'],
            elixirMainEventContact:
                elixirMainEventListFromJson['elixir_event_contact']))
        .toList();
    setState(() {
      listElixirEventItems = final_list;
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
      body: StreamBuilder(
          stream: slides,
          builder: (context, AsyncSnapshot snap) {
            readData();
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List slideList = snap.data.toList();
            return Column(
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: slideList.length,
                  itemBuilder: (context, index, realIndex) {
                    return _buildStoryPage(slideList[index]);
                  },
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * .8,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                      autoPlayInterval: const Duration(seconds: 3)),
                ),
              ],
            );
          }),
    );
  }

  _buildStoryPage(Map data) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: data['elixir_event_image'],
          imageBuilder: (context, imageProvider) => Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.colorBurn)),
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Text(
          data['elixir_event_title'].toString().toUpperCase(),
          style: GoogleFonts.secularOne(fontSize: 24, color: blue),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Divider(height: 1, color: blue),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Time : ',
                  style: TextStyle(color: blue),
                ),
                Text(
                  data['elixir_event_time'].toString().toUpperCase(),
                  style: TextStyle(color: blue, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Venue : ',
                  style: TextStyle(color: blue),
                ),
                Text(
                  data['elixir_event_venue'].toString().toUpperCase(),
                  style: TextStyle(color: blue, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(data['elixir_event_description'],
              textAlign: TextAlign.justify,
              style: GoogleFonts.alegreya(
                  color: blue, fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        Column(
          children: [
            Text(
              'Contact Info',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, color: blue),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+91 ${data['elixir_event_contact']}',
                    style: TextStyle(color: blue),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    child: Icon(Icons.copy, color: blue, size: 20),
                    onTap: () async {
                      Clipboard.setData(
                          ClipboardData(text: data['elixir_event_contact']));
                      _showSnackBar();
                    },
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  void _showSnackBar() {
    const snack =
        SnackBar(content: Text("Text copied"), duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
