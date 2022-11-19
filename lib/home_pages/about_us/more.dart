import 'package:elites_app_22/home_pages/about_us/developer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class more_page extends StatefulWidget {
  @override
  State<more_page> createState() => _more_pageState();
}

class _more_pageState extends State<more_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
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
          Padding(
            padding:
                const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                "assets/images/elites_logo.png",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              '     ELITES-Electrical Integrated Team of Engineering Students is the department of the Electrical & Electronics Engineering student association. '
              'The association conducts student enrichment programs to build technical skills, leadership qualities, and overall personality development of the students.'
              ' The significant events are Elixir, Geomitra, Seminar week, Special guest lectures, Student development program, and Alumni interaction.',
              style: GoogleFonts.alegreya(
                  fontSize: 18, color: blue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                    final Uri url = Uri.parse(
                        "https://forms.gle/BUFLfGSMDnEGLNKV7");
                    open_browser_url(url: url, inApp: true);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration:
                        BoxDecoration(borderRadius: borderRadius, color: blueBg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        FaIcon(Icons.feedback),
                        Text('Feedback')
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>developer()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration:
                        BoxDecoration(borderRadius: borderRadius, color: blueBg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [FaIcon(Icons.android), Text('Developers')],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10.0),
                    child: Text(
                      "Follow Us",
                      style: GoogleFonts.secularOne(fontSize: 18, color: blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final Uri url = Uri.parse(
                                "https://www.instagram.com/eee_nmamit/");
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
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  void open_browser_url({required Uri url, required bool inApp}) async {
    if (await canLaunchUrl(url)) {
      await (launchUrl(url, mode: LaunchMode.externalApplication));
    }
  }
}
