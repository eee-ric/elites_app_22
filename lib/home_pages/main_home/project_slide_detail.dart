import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class project_slide_detail extends StatefulWidget {
  const project_slide_detail({Key? key}) : super(key: key);

  @override
  State<project_slide_detail> createState() => _project_slide_detailState();
}

class _project_slide_detailState extends State<project_slide_detail> {
  final borderRadius = BorderRadius.circular(25);
  final logoRed = const Color.fromRGBO(103, 0, 1, 20);
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
            if (snap.hasError) {
              const Text('Error!');
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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
                      height: MediaQuery.of(context).size.height,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                      autoPlayInterval: const Duration(seconds: 3)),
                ),
              ],
            );
          }

          ),
    );
  }

  _buildStoryPage(Map data) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CachedNetworkImage(
              imageUrl: data['image'],
              imageBuilder: (context, imageProvider) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  height: 200,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: (Text(data['title'].toString().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.secularOne(
                          color: logoRed,
                          fontSize: 24,
                        ))),
                  ),
                  Text(data['description'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alegreya(
                          color: logoRed, fontSize: 18)),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
