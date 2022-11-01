import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_sub_pages/elixir/elixir_season_explore.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_sub_pages/elixir/firebase_file.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'elixir_list.dart';

class elixir extends StatefulWidget {
  const elixir({Key? key}) : super(key: key);

  @override
  State<elixir> createState() => _elixirState();
}

class _elixirState extends State<elixir> {
  List<ElixirList> listElixirItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('elixir_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var final_list = ListRecord.docs
        .map((elixirListFromJson) => ElixirList(
            elixirImage: elixirListFromJson['elixir_image'],
            elixirTitle: elixirListFromJson['elixir_title'],
            elixirImageGallery: elixirListFromJson['elixir_image_gallery'],
            elixirDetail: elixirListFromJson['elixir_detail']))
        .toList();
    setState(() {
      listElixirItems = final_list;
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
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'ELIXIR...\n Department of Electrical & Electronics Engineering at NMAM Institute of Technology, '
                'introduced a student hobby project exhibition ELIXIR in the year 2011 aiming at "Transforming Ideas into Reality".'
                ' This platform facilitates engineering students to improve their ideas and learn mathematical equations by building workable models.'
                ' Students utilize their time in the laboratory and work in groups to enhance technical competence.'
                ' The event is well supported, encouraged, and sponsored by department alumni.',
                style: GoogleFonts.alegreya(
                    fontSize: 18, color: logoRed, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: listElixirItems.length,
              itemBuilder: (BuildContext context, int index) {
                ElixirList elixirListOrder = listElixirItems[index];
//onTAP FOR INDEX ITEMS
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                elixir_season_explore(elixirListOrder)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: logoRed,
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: listElixirItems[index].elixirImage,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 200,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: Colors.white, blurRadius: 5)
                                ],
                                borderRadius: borderRadius,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.colorBurn),
                                ),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    listElixirItems[index].elixirTitle,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.secularOne(
                                        fontSize: 40,
                                        color: Colors.white,
                                        textStyle: TextStyle(shadows: <Shadow>[
                                          const Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 20.0,
                                              color: Colors.white),
                                          Shadow(
                                              offset: const Offset(5.0, 5.0),
                                              blurRadius: 10.0,
                                              color: logoRed),
                                        ])),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              listElixirItems[index].elixirDetail,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
