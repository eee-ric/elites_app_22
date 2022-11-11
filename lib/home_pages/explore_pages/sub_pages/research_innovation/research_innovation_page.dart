import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/internship/internship_page.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/research_innovation/project_videos/project_video_main.dart';
import 'package:elites_app_22/home_pages/main_home/project_slide_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class research_innovation_page extends StatefulWidget {
  const research_innovation_page({Key? key}) : super(key: key);

  @override
  State<research_innovation_page> createState() =>
      _research_innovation_pageState();
}

const logoRed = Color.fromRGBO(103, 0, 1, 20);
const CardBG = Color.fromRGBO(242, 240, 197, 86);
final borderRadius = BorderRadius.circular(25);

class _research_innovation_pageState extends State<research_innovation_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Research and Innovation Center'),
        backgroundColor: const Color.fromRGBO(103, 0, 1, 20),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '\t \t   Center for Design of Power Electronic Systems is a research lab of the department housed at the Research and Innovation Center of the college. '
              'The center\'s prime focus is cultivating research habits amongst engineering students and creating a platform for students to have hassle-free entry into the industries. '
              'Research and Innovation Center provides exposure to: '
              '\n\n• Product Life cycle management '
              '\n• Hardware design and development'
              '\n• PCB assembly '
              '\n• Software developed for power electronics applications '
              '\n• Industry interaction'
              '\n •Train Students to make them Industry ready',
              style: GoogleFonts.alegreya(
                  fontSize: 18, color: logoRed, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const internship_page()));

                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: logoRed),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Internship',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 30,
                  top: 5,
                ),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const project_slide_detail()));
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: logoRed),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Project Images',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>project_video_main()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 5,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: logoRed),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Project Videos',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
