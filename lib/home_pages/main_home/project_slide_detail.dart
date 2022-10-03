
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class project_slide_detail extends StatefulWidget {

  const project_slide_detail({Key? key}) : super(key: key);

  @override
  State<project_slide_detail> createState() => _project_slide_detailState();
}

class _project_slide_detailState extends State<project_slide_detail> {

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
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: slideList.length,
                  itemBuilder: (context, index, realIndex) {
                    return _buildStoryPage(slideList[index]);
                  },
                  options: CarouselOptions(
                    height: 500,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                      autoPlayInterval: Duration(seconds: 3)),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // _buiderIndicator(),
              ],
            );
          }),
    );
  }

  // Widget _buiderIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: activeIndex,
  //       count: activeIndex,
  //       effect: JumpingDotEffect(dotWidth: 10, dotHeight: 10,dotColor: Colors.grey,activeDotColor: Color.fromRGBO(103, 0, 1, 20),),
  //     );

  _buildStoryPage(Map data) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 20),
            Text(data['title']),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(),
            ),
            Image(
              image: NetworkImage(data['image']),
              fit: BoxFit.cover,
                height: 200,
            )
          ]),
        ),
      ),
    );

    // image: NetworkImage(data['image']), fit: BoxFit.cover)),
    // child: Center(
    //   child: Text(data['title']),
    // ),
  }
}
