import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elites_app_22/home_pages/elixir_main/layout_pdf/pdf_layout.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/layout_left.dart';
import 'package:elites_app_22/home_pages/elixir_main/sadananda_layout/layout_right.dart';
import 'package:flutter/material.dart';
class layout_main extends StatefulWidget {
  const layout_main({Key? key}) : super(key: key);

  @override
  State<layout_main> createState() => _layout_mainState();
}

class _layout_mainState extends State<layout_main> {

  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      const layout_left_main(),
      const pdf_layout(),
      const layout_right_main(),
    ];
    return Scaffold(

      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: blue,
        animationDuration: const Duration(milliseconds: 500),
        index: index,
        onTap: (index) =>
            setState(() {
              this.index = index;
            }),
        items: const [
          Icon(
            Icons.keyboard_double_arrow_left_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.map,
            color: Colors.white,
          ),
          Icon(
            Icons.keyboard_double_arrow_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
