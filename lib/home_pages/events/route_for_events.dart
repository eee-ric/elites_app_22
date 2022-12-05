import 'package:cached_network_image/cached_network_image.dart';
import 'package:elites_app_22/home_pages/events/event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class route_events extends StatelessWidget {
  EventList eventList;

  route_events(this.eventList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            CachedNetworkImage(
              imageUrl: eventList.eventPoster,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
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
            const Divider(),
            Column(
              children: [
                Text(
                  eventList.eventTitle.toString().toUpperCase(),
                  style: GoogleFonts.secularOne(fontSize: 24, color: blue),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(height: 1, color: blue),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Time : ',
                          style: TextStyle(color: blue),
                        ),
                        Text(
                          eventList.eventDate.toString().toUpperCase(),
                          style: const TextStyle(
                              color: blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Venue : ',
                          style: TextStyle(color: blue),
                        ),
                        Text(
                          eventList.eventVenue.toString().toUpperCase(),
                          style: const TextStyle(
                              color: blue, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(eventList.eventDescription,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.alegreya(
                          color: blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                Column(
                  children: [
                    const Text(
                      'Contact Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: blue),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+91 ${eventList.eventContact}',
                            style: const TextStyle(color: blue),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: const Icon(Icons.copy, color: blue, size: 20),
                            onTap: () async {
                              Clipboard.setData(
                                  ClipboardData(text: eventList.eventContact));
                              const snack = SnackBar(
                                  content: Text("Text copied"),
                                  duration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
