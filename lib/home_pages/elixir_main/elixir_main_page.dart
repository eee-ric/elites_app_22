import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_main_event_list.dart';
import 'package:elites_app_22/home_pages/elixir_main/elixir_event_detail_.dart';
import 'package:elites_app_22/home_pages/elixir_main/invitation_video.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/layout_main.dart';
import 'package:elites_app_22/home_pages/elixir_main/layout_pdf/pdf_layout.dart';
import 'package:elites_app_22/home_pages/elixir_main/projects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'elixir_project_lists.dart';

class elixir_main_page extends StatefulWidget {
  const elixir_main_page({Key? key}) : super(key: key);

  @override
  State<elixir_main_page> createState() => _elixir_main_pageState();
}

class _elixir_main_pageState extends State<elixir_main_page> {
  List<ElixirMainEventList> listElixirEventItems = [];

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
        .collection('elixir_main_event_list')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }

  Future readData() async {
    final QuerySnapshot result = (await FirebaseFirestore.instance
            .collection('elixir_main_event_list')
            .snapshots()
            .map((list) => list.docs.map((doc) => doc.data())))
        as QuerySnapshot<Object?>;
    final List<DocumentSnapshot> list = result.docs;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('elixir_main_event_list', <String>[
      'elixir_event_image',
      'elixir_event_title',
      'elixir_event_venue',
      'elixir_event_time',
      'elixir_event_description',
      'elixir_event_contact'
    ]);
    final List<String>? items = prefs.getStringList('elixir_main_event_list');
  }

  final CarouselController controller = CarouselController();

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var final_list = ListRecord.docs
        .map((elixirMainEventListFromJson) => ElixirMainEventList(
            elixirMainEventImage:
                elixirMainEventListFromJson['elixir_event_image'],
            elixirMainEventTitle:
                elixirMainEventListFromJson['elixir_event_title'],
            elixirMainEventVenue:
                elixirMainEventListFromJson['elixir_event_venue'],
            elixirMainEventTime:
                elixirMainEventListFromJson['elixir_event_time'],
            elixirMainEventDescription:
                elixirMainEventListFromJson['elixir_event_description'],
            elixirMainEventContact:
                elixirMainEventListFromJson['elixir_event_contact']))
        .toList();
    setState(() {
      listElixirEventItems = final_list;
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
        title: const Text('ELIXIR'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const invitation_video()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 20, top: 20),
                  child: Container(

                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: blue),
                        borderRadius: BorderRadius.circular(25), color: blueBg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mark_email_unread,
                          color: blue,
                          size: 34,
                        ),
                        Center(
                            child: Text(
                          'Invitation',
                          style:
                              GoogleFonts.secularOne(fontSize: 24, color: blue),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const layout_main()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10, top: 20),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: blue),
                        borderRadius: BorderRadius.circular(25), color: blueBg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.layers_outlined,
                          color: blue,
                          size: 34,
                        ),
                        Center(
                            child: Text(
                          'Layout',
                          style:
                              GoogleFonts.secularOne(fontSize: 24, color: blue),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              const double latitude = 13.182887;
              const double longitude = 74.935400;
              final Uri url = Uri.parse(
                  'https://www.google.com/maps/search/$latitude,$longitude');
              open_browser_url(url: url, inApp: true);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: blueBg,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/land_map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent),
                        alignment: Alignment.topLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                'Map',
                                style: GoogleFonts.secularOne(color: blue),
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: blue),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.diamondTurnRight,
                                  color: yellow,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: blueBg,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: borderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(

                  children: [
                    Text(
                      'ELIXIR 2022',
                      style: GoogleFonts.alegreya(fontSize: 24,color: Colors.red),
                    ),
                    Text(
                      'Agenda',
                      style: GoogleFonts.alegreya(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Invocation',
                      style: GoogleFonts.alegreya(fontWeight: FontWeight.bold),
                    ),
                    Table(
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome & About Elixir :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Suryanarayana K',
                                  style: TextStyle(color: blue, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chief Guest Address :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shri. Vishal Hegde',
                                  style: TextStyle(color: blue, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Prize Distribution',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Table(
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Presidential Remarks :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Niranjan N. Chiplunkar',
                                  style: TextStyle(color: blue, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vote of Thanks :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mr. Samith Suvarna',
                                  style: TextStyle(color: blue, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding:
                         const EdgeInsets.only(right: 10, left: 10, top: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                             Text(
                               'ELIXIR Inauguration\n \n Product Launch',
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 12,
                                   fontWeight: FontWeight.bold),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding:
                         const EdgeInsets.only(right: 10, left: 10, top: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                             Text(
                               '\t \t 1. Electric Omni',
                               style: TextStyle(color: Colors.black, fontSize: 12),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding:
                         const EdgeInsets.only(right: 10, left: 10, top: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                             Text(
                               '\t \t 2. Solar Street Light',
                               style: TextStyle(color: Colors.black, fontSize: 12),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding:
                         const EdgeInsets.only(right: 10, left: 10, top: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                             Text(
                               '\t \t 3. Inventory Management',
                               style: TextStyle(color: Colors.black, fontSize: 12),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       Padding(
                         padding:
                         const EdgeInsets.only(right: 10, left: 10, top: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                             Text(
                               'Master of Ceremony - Ms. Jane \nDate : 21 November 2022 \nTime : 11:15am \nVenue : Sadananda Auditorium',
                               style: TextStyle(color: Colors.black, fontSize: 12),
                             ),
                           ],
                         ),
                       ),
                     ],
                   )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(color: yellow),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Events',
                        textAlign: TextAlign.left,
                        style:
                            GoogleFonts.secularOne(color: blue, fontSize: 24),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: slides,
                      builder: (context, AsyncSnapshot snap) {
                        readData();
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                            const elixir_event_detail()));
                              },
                              child: CarouselSlider.builder(
                                carouselController: controller,
                                itemCount: slideList.length,
                                itemBuilder: (context, index, realIndex) {
                                  return _buildStoryPage(slideList[index]);
                                },
                                options: CarouselOptions(
                                    height: 250,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) =>
                                        setState(() => activeIndex = index),
                                    autoPlayInterval:
                                        const Duration(seconds: 3)),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const elixir_projects()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: blueBg,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/swayam.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Container(
                  decoration:
                      BoxDecoration(color: blue, borderRadius: borderRadius),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      'Projects',
                      style: GoogleFonts.secularOne(
                          fontSize: 34,
                          color: Colors.white,
                          shadows: <Shadow>[
                            const Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 20.0,
                                color: Colors.white),
                            Shadow(
                                offset: const Offset(2.0, 2.0),
                                blurRadius: 10.0,
                                color: blue),
                          ]),
                    ),
                  ),
                )),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: yellow),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      final Uri url =
                          Uri.parse("https://www.instagram.com/eee_nmamit/");
                      open_browser_url(url: url, inApp: true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FaIcon(FontAwesomeIcons.instagram),
                        Text(
                          "eee_nmamit",
                          style: GoogleFonts.secularOne(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                          "https://www.linkedin.com/in/electrical-and-electronics-engineering-316a62176/");
                      open_browser_url(url: url, inApp: true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FaIcon(FontAwesomeIcons.linkedin),
                        Text(
                          "EEE NMAMIT",
                          style: GoogleFonts.secularOne(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                          "https://www.youtube.com/channel/UC7ve97BbEy44KPFca2FgxJg");
                      open_browser_url(url: url, inApp: true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FaIcon(FontAwesomeIcons.youtube),
                        Text(
                          "Elites NMAMIT",
                          style: GoogleFonts.secularOne(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildStoryPage(Map data) {
    return CachedNetworkImage(
      imageUrl: data['elixir_event_image'],
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
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

  void open_browser_url({required Uri url, required bool inApp}) async {
    if (await canLaunchUrl(url)) {
      await (launchUrl(url, mode: LaunchMode.externalApplication));
    }
  }
}
