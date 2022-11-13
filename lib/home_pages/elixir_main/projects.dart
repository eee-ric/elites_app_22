import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_project_detail.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_project_lists.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class elixir_projects extends StatefulWidget {
  const elixir_projects({Key? key}) : super(key: key);

  @override
  State<elixir_projects> createState() => _elixir_projectsState();
}

class _elixir_projectsState extends State<elixir_projects> {
  List<ElixirProjectList> listElixirProjectItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
    await FirebaseFirestore.instance.collection('elixir_project_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((elixirProjectListFromJson) =>
        ElixirProjectList(
            elixirProjectListImage: elixirProjectListFromJson['elixir_project_image'],
            elixirProjectListName: elixirProjectListFromJson['elixir_project_name'],
            elixirProjectListDescription: elixirProjectListFromJson['elixir_project_description'],
            elixirProjectListVideo: elixirProjectListFromJson['elixir_project_video']))
        .toList();
    setState(() {
      listElixirProjectItems = finalList;
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
          title: const Text('Projects'),
          backgroundColor: blue,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: listElixirProjectItems.length,
          itemBuilder: (BuildContext context, int index) {
            //onTAP FOR INDEX ITEMS
            ElixirProjectList elixirProjectListOrder = listElixirProjectItems[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>elixir_project_less(elixirProjectListOrder)));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: blueBg,
                    // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //EXPLORE IMAGE
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CachedNetworkImage(
                          imageUrl: listElixirProjectItems[index].elixirProjectListImage,
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .35,
                                height: 120,
                                decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   new BoxShadow(color: logoRed, blurRadius: 5)
                                  // ],
                                  borderRadius: borderRadius,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.white, BlendMode.colorBurn)),
                                ),
                              ),
                        ),
                      ),

                      //EXPLORE TITLE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .5,
                          child: Text(
                            listElixirProjectItems[index].elixirProjectListName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.secularOne(fontSize: 22),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
