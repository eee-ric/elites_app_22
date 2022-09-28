import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class home_main_page extends StatefulWidget {
  const home_main_page({Key? key}) : super(key: key);

  @override
  State<home_main_page> createState() => _home_main_pageState();
}

class _home_main_pageState extends State<home_main_page> {
  late Stream slides;

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
              return CarouselSlider.builder(
                carouselController: controller,
                itemCount: slideList.length,
                itemBuilder: (context, index,realIndex) {
                  return _buildStoryPage(slideList[index]);
                },
                options: CarouselOptions(height: 400),
              );
            }));
  }

  _buildStoryPage(Map data) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(data['image']))),
      child: Center(
        child: Text(data['title']),
      ),
    );
    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
  }
}
