import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elites_app_22/home_pages/events_page.dart';
import 'package:elites_app_22/home_pages/explore_pages/explore.dart';
import 'package:elites_app_22/home_pages/main_home/home_main_page.dart';
import 'package:elites_app_22/home_pages/more.dart';
import 'package:flutter/material.dart';

import 'notifications.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  final blue = const Color.fromRGBO(0, 0, 153, 30);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(255, 216, 0, 50);
  int index = 2;

  @override
  Widget build(BuildContext context) {
    final screens = [

      const notifications(),
      const events_page(),
      const home_main_page(),
      const explore(),
      const more_page(),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: blue,
        animationDuration: const Duration(milliseconds: 500),
        index: index,
        onTap: (index)=>setState(() {
          this.index=index;
        }),
        items: const [
          Icon(
            Icons.notifications_outlined,
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
