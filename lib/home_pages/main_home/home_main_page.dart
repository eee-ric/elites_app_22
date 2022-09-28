import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/main_home/project_slide_detail.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class home_main_page extends StatefulWidget {
  const home_main_page({Key? key}) : super(key: key);

  @override
  State<home_main_page> createState() => _home_main_pageState();
}

class _home_main_pageState extends State<home_main_page> {
  late Stream slides;
  int activeIndex = 0;

  Stream queryDb() {
    slides = FirebaseFirestore.instance
        .collection('projects_slider')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }

  @override
  void initState() {
    queryDb();
    super.initState();
  }

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: slides,
            builder: (context, AsyncSnapshot snap) {
              List slideList = snap.data.toList();
              if (snap.hasError) {}
              if (snap.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  project_slide_detail()));
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
                          autoPlayInterval: Duration(seconds: 3)),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // _buiderIndicator(),
                ],
              );
            }));
  }

  // Widget _buiderIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: activeIndex,
  //       count: activeIndex,
  //       effect: JumpingDotEffect(dotWidth: 10, dotHeight: 10,dotColor: Colors.grey,activeDotColor: Color.fromRGBO(103, 0, 1, 20),),
  //     );

  _buildStoryPage(Map data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
              image: NetworkImage(data['image']), fit: BoxFit.cover)),
      // child: Center(
      //   child: Text(data['title']),
      // ),
    );
  }
}
