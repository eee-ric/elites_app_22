import 'package:flutter/material.dart';

class explore extends StatefulWidget {
  const explore({Key? key}) : super(key: key);

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  final item = List<String>.generate(30, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          backgroundColor: Color.fromRGBO(103, 0, 1, 20),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        body: ListView.custom(childrenDelegate:
            SliverChildBuilderDelegate((BuildContext contex, int index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: SizedBox(height: 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                Text(
                  item[index],
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        })));
  }
}
