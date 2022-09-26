import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elites_app_22/home_pages/events_page.dart';
import 'package:elites_app_22/home_pages/explore.dart';
import 'package:elites_app_22/home_pages/facilities.dart';
import 'package:elites_app_22/home_pages/home_main_page.dart';
import 'package:elites_app_22/home_pages/more.dart';
import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  int index = 2;

  @override
  Widget build(BuildContext context) {
    final screens = [
      explore_page(),
      events_page(),
      home_main_page(),
      facilities_page(),
      more_page(),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      appBar: AppBar(
        title: Text('Elites'),
        backgroundColor: Color.fromRGBO(103, 0, 1, 20),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(103, 0, 1, 20),
        animationDuration: Duration(milliseconds: 500),
        index: index,
        items: [
          Icon(
            Icons.travel_explore,
            color: Colors.white,
          ),
          Icon(
            Icons.event,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.account_tree,
            color: Colors.white,
          ),
          Icon(
            Icons.more_vert_sharp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
