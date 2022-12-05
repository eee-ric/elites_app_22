import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/ric_project_list/ric_pro_main.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/layout_global_detail.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/top_left_list.dart';
import 'package:elites_app_22/home_pages/events/events_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class layout_left_main extends StatefulWidget {
  const layout_left_main({Key? key}) : super(key: key);

  @override
  State<layout_left_main> createState() => _layout_left_mainState();
}

class _layout_left_mainState extends State<layout_left_main> {
  List<TopLeft> list1 = [];
  List<TopLeft> list = [];
  List<TopLeft> list2 = [];

  @override
  void initState() {
    fetchData();
    fetchData1();
    fetchData2();
    super.initState();
  }

  fetchData() async {
    var ListRecord = await FirebaseFirestore.instance
        .collection('left_row_layout_list')
        .get();
    mapListRecord(ListRecord);
  }

  fetchData1() async {
    var ListRecord1 =
        await FirebaseFirestore.instance.collection('left_list').get();
    mapListRecord1(ListRecord1);
  }

  fetchData2() async {
    var ListRecord2 =
        await FirebaseFirestore.instance.collection('bottom_left').get();
    mapListRecord2(ListRecord2);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((topLeftListFromJson) => TopLeft(
            title: topLeftListFromJson['title'],
            image: topLeftListFromJson['image'],
            video: topLeftListFromJson['video'],
            description: topLeftListFromJson['description'],
            sl_number: topLeftListFromJson['sl_number']))
        .toList();
    setState(() {
      list = finalList;
    });
  }

  mapListRecord1(QuerySnapshot<Map<String, dynamic>> ListRecord1) {
    var finalList1 = ListRecord1.docs
        .map((topLeftListFromJson) => TopLeft(
            title: topLeftListFromJson['title'],
            image: topLeftListFromJson['image'],
            video: topLeftListFromJson['video'],
            description: topLeftListFromJson['description'],
            sl_number: topLeftListFromJson['sl_number']))
        .toList();
    setState(() {
      list1 = finalList1;
    });
  }

  mapListRecord2(QuerySnapshot<Map<String, dynamic>> ListRecord2) {
    var finalList2 = ListRecord2.docs
        .map((topLeftListFromJson) => TopLeft(
            title: topLeftListFromJson['title'],
            image: topLeftListFromJson['image'],
            video: topLeftListFromJson['video'],
            description: topLeftListFromJson['description'],
            sl_number: topLeftListFromJson['sl_number']))
        .toList();
    setState(() {
      list2 = finalList2;
    });
  }

  final blue = const Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253, 185, 19, 50);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sadananda'),
        backgroundColor: blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ric_project()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: blue),
                  boxShadow: [
                    BoxShadow(
                      color: blueBg,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    'R.I.C ',
                    style: GoogleFonts.secularOne(
                        fontSize: 30,
                        color: blue,
                        shadows: <Shadow>[
                          const Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 10.0,
                              color: Colors.white),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => events_page()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: blue),
                  boxShadow: [
                    BoxShadow(
                      color: blueBg,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: Text(
                    'Gaming Zone',
                    style: GoogleFonts.secularOne(
                        fontSize: 30,
                        color: blue,
                        shadows: <Shadow>[
                          const Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 20.0,
                              color: Colors.white),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: blue,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Move Right",
                style: GoogleFonts.secularOne(color: blue),
              ),
              FaIcon(
                Icons.keyboard_double_arrow_right,
                color: blue,
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 180,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            TopLeft topLeftOrder0 = list[index];
                            //onTAP FOR INDEX ITEMS
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            layout_global_detail(
                                                topLeftOrder0)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 10),
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: blueBg,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    borderRadius: borderRadius,
                                    color: blueBg,
                                    // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: list[index].image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            // boxShadow: [
                                            //   new BoxShadow(color: logoRed, blurRadius: 5)
                                            // ],
                                            borderRadius: borderRadius,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Colors.white,
                                                        BlendMode.colorBurn)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              list[index].sl_number,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                        offset: Offset(0, 0),
                                                        blurRadius: 10,
                                                        color: Colors.black),
                                                    Shadow(
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                        blurRadius: 10.0,
                                                        color: Colors.black),
                                                  ],
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //EXPLORE TITLE
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        child: Text(
                                          list[index].title.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.secularOne(
                                              ),
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Move Down",
                          style: GoogleFonts.secularOne(color: blue),
                        ),
                        FaIcon(
                          Icons.keyboard_double_arrow_down,
                          color: blue,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                            itemCount: list1.length,
                            itemBuilder: (BuildContext context, int index) {
                              TopLeft topLeftOrder1 = list1[index];

                              //onTAP FOR INDEX ITEMS
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              layout_global_detail(
                                                  topLeftOrder1)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: blueBg,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                      borderRadius: borderRadius,
                                      color: blueBg,
                                      // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: list1[index].image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .35,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .22,
                                            decoration: BoxDecoration(
                                              // boxShadow: [
                                              //   new BoxShadow(color: logoRed, blurRadius: 5)
                                              // ],
                                              borderRadius: borderRadius,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.white,
                                                          BlendMode.colorBurn)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                list1[index].sl_number,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                          offset: Offset(0, 0),
                                                          blurRadius: 10,
                                                          color: Colors.black),
                                                      Shadow(
                                                          offset:
                                                              Offset(2.0, 2.0),
                                                          blurRadius: 10.0,
                                                          color: Colors.black),
                                                    ],
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //EXPLORE TITLE
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              list1[index].title.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.secularOne(
                                                  fontSize: 16),
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ),
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.height * 0.15,
                            child: ListView.builder(
                              itemCount: list2.length,
                              itemBuilder: (BuildContext context, int index) {
                                TopLeft topLeftOrder2 = list2[index];

                                //onTAP FOR INDEX ITEMS
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                layout_global_detail(
                                                    topLeftOrder2)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10, top: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: blueBg,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius: borderRadius,
                                        color: blueBg,
                                        // boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: list2[index].image,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .22,
                                              decoration: BoxDecoration(
                                                // boxShadow: [
                                                //   new BoxShadow(color: logoRed, blurRadius: 5)
                                                // ],
                                                borderRadius: borderRadius,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            Colors.white,
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  list2[index].sl_number,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                            offset:
                                                                Offset(0, 0),
                                                            blurRadius: 10,
                                                            color:
                                                                Colors.black),
                                                        Shadow(
                                                            offset: Offset(
                                                                2.0, 2.0),
                                                            blurRadius: 10.0,
                                                            color:
                                                                Colors.black),
                                                      ],
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //EXPLORE TITLE
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .35,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                list2[index].title.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.secularOne(
                                                    fontSize: 16),
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              ),
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height*1.1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(25)),
                      color: blue),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: SizedBox(
                        child: FittedBox(
                            child: Text(
                          'Footway',
                          style: GoogleFonts.secularOne(color: Colors.white),
                        )),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
