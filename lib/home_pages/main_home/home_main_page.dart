
import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_main_page.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/internship_page.dart';
import 'package:elites_app_22/home_pages/main_home/project_slide_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_main_page extends StatefulWidget {
  const home_main_page({Key? key}) : super(key: key);

  @override
  State<home_main_page> createState() => _home_main_pageState();
}

class _home_main_pageState extends State<home_main_page> {
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
        .collection('projects_slider')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }

  Future readData() async {
    final QuerySnapshot result = (await FirebaseFirestore.instance
            .collection('projects_slider')
            .snapshots()
            .map((list) => list.docs.map((doc) => doc.data())))
        as QuerySnapshot<Object?>;
    final List<DocumentSnapshot> list = result.docs;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('projects_slider', <String>['image', 'title']);
    final List<String>? items = prefs.getStringList('projects_slider');
  }

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('EEE NMAMIT'),
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
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 30, bottom: 30),
              child: Column(
                children: [
                  Text(
                    'Department Of',
                    style: GoogleFonts.secularOne(
                        fontSize: 22, color: Colors.black),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        'ELECTRICAL AND ELECTRONICS',
                        style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.w400, color: logoRed),
                      ),
                    ),
                  ),
                  Text(
                    'Engineering',
                    style: GoogleFonts.secularOne(
                        fontSize: 22, color: Colors.black),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: slides,
                builder: (context, AsyncSnapshot snap) {
                  readData();
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
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
                                      const project_slide_detail()));
                        },
                        child: CarouselSlider.builder(
                          carouselController: controller,
                          itemCount: slideList.length,
                          itemBuilder: (context, index, realIndex) {
                            return _buildStoryPage(slideList[index]);
                          },
                          options: CarouselOptions(
                              height: 250,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index),
                              autoPlayInterval: const Duration(seconds: 3)),
                        ),
                      ),
                    ],
                  );
                }),




            //   ELIXIR MAIN
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>elixir_main_page()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 30, bottom: 10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black12, borderRadius: borderRadius),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ELIXIR",
                          style: GoogleFonts.secularOne(
                              fontWeight: FontWeight.w400,
                              fontSize: 50,
                              color: logoRed,
                              shadows: <Shadow>[
                                const Shadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 20.0,
                                    color: Colors.white),
                                const Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 10.0,
                                    color: logoRed),
                              ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text('Time : 21 NOV 22'),
                                Text('Venue : Sadananda Auditorium')
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: logoRed,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: (Text(
                                  'Explore',
                                  style: GoogleFonts.secularOne(fontSize: 18,color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _buildStoryPage(Map data) {
    return CachedNetworkImage(
      imageUrl: data['image'],
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
