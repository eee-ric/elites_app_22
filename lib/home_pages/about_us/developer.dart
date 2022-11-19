import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';
import 'developer_list.dart';

class developer extends StatefulWidget {
  const developer({Key? key}) : super(key: key);

  @override
  State<developer> createState() => _developerState();
}

class _developerState extends State<developer> {
  List<DeveloperList> listDeveloperItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('developer_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((developerListFromJson) => DeveloperList(
            developerImage: developerListFromJson['developer_image'],
            developerName: developerListFromJson['developer_name'],
            developerInsta: developerListFromJson['developer_insta'],
            developerLinkedIn: developerListFromJson['developer_linked_in'],
            developerMail: developerListFromJson['developer_mail']))
        .toList();
    setState(() {
      listDeveloperItems = finalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Developers'),
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
            itemCount: listDeveloperItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration:
                      BoxDecoration(color: blueBg, borderRadius: borderRadius),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                          height: 140,
                          width: 140,
                          imageUrl: listDeveloperItems[index].developerImage,
                          imageBuilder: (context, imageProvider) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 82,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height*0.03,
                                    child: FittedBox(
                                      child: Text(
                                        listDeveloperItems[index].developerName,
                                        style: GoogleFonts.secularOne(
                                             color: blue),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          final Uri url = Uri.parse(
                                              listDeveloperItems[index]
                                                  .developerInsta);
                                          open_browser_url(
                                              url: url, inApp: true);
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.instagram,

                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        final Uri url = Uri.parse(
                                            listDeveloperItems[index]
                                                .developerLinkedIn);
                                        open_browser_url(url: url, inApp: true);
                                      },
                                      child: const FaIcon(
                                        FontAwesomeIcons.linkedin,

                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                            ClipboardData(text:listDeveloperItems[index].developerMail));
                                        _showSnackBar();
                                      },
                                      child: const FaIcon(
                                        Icons.mail,

                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  void open_browser_url({required Uri url, required bool inApp}) async {
    if (await canLaunchUrl(url)) {
      await (launchUrl(url, mode: LaunchMode.externalApplication));
    }
  }
  void _showSnackBar() {
    const snack =
    SnackBar(content: Text("Email Copied"), duration: Duration(seconds: 3));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
