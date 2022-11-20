import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_sub_pages/elixir/elixir.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'elites_list.dart';

class elites_main_page extends StatefulWidget {
  const elites_main_page({Key? key}) : super(key: key);

  @override
  State<elites_main_page> createState() => _elites_main_pageState();
}

class _elites_main_pageState extends State<elites_main_page> {
  List<ElitesList> listElitesItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('elites_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((elitesListFromJson) => ElitesList(
            elitesImage: elitesListFromJson['elites_image'],
            elitesTitle: elitesListFromJson['elites_title']))
        .toList();
    setState(() {
      listElitesItems = finalList;
    });
  }

  final blue = const Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253, 185, 19, 50);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    const blue = Color.fromRGBO(46, 49, 146, 38);
    const blueBg = Color.fromRGBO(149, 157, 244, 77);
    const yellow = Color.fromRGBO(253, 185, 19, 50);
    final borderRadius = BorderRadius.circular(25);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ELITES'),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/elites_logo.png',
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '     ELITES-Electrical Integrated Team of Engineering Students is the department of the Electrical & Electronics Engineering student association. '
                      'The association conducts student enrichment programs to build technical skills, leadership qualities, and overall personality development of the students.'
                      ' The significant events are Elixir, Geomitra, Seminar week, Special guest lectures, Student development program, and Alumni interaction.',
                      style: GoogleFonts.alegreya(
                          fontSize: 18,
                          color: blue,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: listElitesItems.length,
                itemBuilder: (BuildContext context, int index) {
//onTAP FOR INDEX ITEMS
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const elixir()));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: const [
                          BoxShadow(
                            color: blueBg,
                            blurRadius: 5.0,
                          ),
                        ], color: yellow, borderRadius: borderRadius),
                        child: CachedNetworkImage(
                          imageUrl: listElitesItems[index].elitesImage,
                          imageBuilder: (context, imageProvider) => Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .3,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: Center(
                                    child: Text(
                                      listElitesItems[index].elitesTitle,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.secularOne(
                                          fontSize: 60,
                                          color: Colors.white,
                                          textStyle:
                                              TextStyle(shadows: <Shadow>[
                                            const Shadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 20.0,
                                                color: Colors.white),
                                            Shadow(
                                                offset: const Offset(5.0, 5.0),
                                                blurRadius: 10.0,
                                                color: blue),
                                          ])),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      maxLines: 4,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
