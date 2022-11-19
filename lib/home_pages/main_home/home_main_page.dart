import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_main_page.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/leader_board_main.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/internship_page.dart';
import 'package:elites_app_22/home_pages/main_home/leader_board_list.dart';
import 'package:elites_app_22/home_pages/main_home/project_slide_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
        .collection('project_slider')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }

  Future readData() async {
    final QuerySnapshot result = (await FirebaseFirestore.instance
            .collection('project_slider')
            .snapshots()
            .map((list) => list.docs.map((doc) => doc.data())))
        as QuerySnapshot<Object?>;
    final List<DocumentSnapshot> list = result.docs;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('project_slider', <String>['image', 'title']);
    final List<String>? items = prefs.getStringList('project_slider');
  }

  final CarouselController controller = CarouselController();
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset("assets/images/nitte_logo.png"),
          ),
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
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 30, bottom: 30),
              child: Column(
                children: [
                  Text(
                    'Department of',
                    style: GoogleFonts.secularOne(
                        fontSize: 22, color: Colors.blue),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        'ELECTRICAL AND ELECTRONICS',
                        style: GoogleFonts.secularOne(
                          fontWeight: FontWeight.w400,
                          color: blue,
                          // shadows: <Shadow>[
                          //    Shadow(
                          //       color: yellow,
                          //       blurRadius: 25,
                          //       )
                          // ,Shadow(
                          //       color: blue,
                          //       blurRadius:15,
                          //       offset: const Offset(1, 1))
                          // ]
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Engineering',
                    style: GoogleFonts.secularOne(
                        fontSize: 22, color: Colors.blue),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: slides,
                builder: (context, AsyncSnapshot snap) {
                  readData();
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(snap.hasError){
                    return const Center(child: CircularProgressIndicator());
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const elixir_main_page()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 30, bottom: 10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: yellow, borderRadius: borderRadius),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText("ELIXIR",
                                  speed: const Duration(milliseconds: 1000),
                                  textStyle: GoogleFonts.secularOne(
                                      fontSize: 60,
                                      color: blue,
                                      shadows: <Shadow>[
                                        const Shadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 20.0,
                                            color: Colors.white),
                                        Shadow(
                                            offset: const Offset(2.0, 2.0),
                                            blurRadius: 10.0,
                                            color: blue),
                                      ])),
                              FadeAnimatedText("ELIXIR",
                                  duration: const Duration(milliseconds: 800),
                                  textStyle: GoogleFonts.secularOne(
                                      fontSize: 60,
                                      color: blue,
                                      shadows: <Shadow>[
                                        const Shadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 20.0,
                                            color: Colors.white),
                                        Shadow(
                                            offset: const Offset(2.0, 2.0),
                                            blurRadius: 10.0,
                                            color: blue),
                                      ]))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Time : 21 NOV 22',
                                  style: TextStyle(color: blue),
                                ),
                                Text(
                                  'Venue : Sadananda Auditorium',
                                  style: TextStyle(color: blue),
                                )
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: (Text(
                                  'Explore',
                                  style: GoogleFonts.secularOne(
                                      fontSize: 18, color: yellow),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => leader_board_main()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: blueBg,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 50, right: 50),
                        child: Image.asset(
                          'assets/images/elites_logo.png',
                          scale: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Leaderboard',
                          style:
                              GoogleFonts.secularOne(color: blue, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
            boxShadow: [
              BoxShadow(
                color: blueBg,
                blurRadius: 5.0,
              ),
            ],
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
