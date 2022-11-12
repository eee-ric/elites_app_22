import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_main_event_list.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_event_detail_.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class elixir_main_page extends StatefulWidget {
  const elixir_main_page({Key? key}) : super(key: key);

  @override
  State<elixir_main_page> createState() => _elixir_main_pageState();
}

class _elixir_main_pageState extends State<elixir_main_page> {
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

  final blue = const Color.fromRGBO(0, 0, 153, 30);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(255, 216, 0, 50);
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: blueBg),
              child: Center(
                  child: Text(
                'Invitation',
                style: GoogleFonts.secularOne(fontSize: 24, color: blue),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: blueBg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: yellow),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: (FaIcon(
                            FontAwesomeIcons.map,
                            color: blue,
                            size: 20,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Map',
                          style:
                              GoogleFonts.secularOne(fontSize: 42, color: blue),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: blue),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.diamondTurnRight,
                                color: yellow,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(color: yellow),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Events :',
                        style:
                            GoogleFonts.secularOne(fontSize: 24, color: blue),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: slides,
                      builder: (context, AsyncSnapshot snap) {
                        readData();
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        List slideList = snap.data.toList();
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const elixir_event_detail()));
                              },
                              child: CarouselSlider.builder(
                                carouselController: controller,
                                itemCount: slideList.length,
                                itemBuilder: (context, index, realIndex) {
                                  return _buildStoryPage(slideList[index]);
                                },
                                options: CarouselOptions(
                                    height: 250,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) =>
                                        setState(() => activeIndex = index),
                                    autoPlayInterval:
                                        const Duration(seconds: 3)),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildStoryPage(Map data) {
    return CachedNetworkImage(
      imageUrl: data['elixir_event_image'],
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
          ),
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
