import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class home_main_page extends StatefulWidget {
  const home_main_page({Key? key}) : super(key: key);

  @override
  State<home_main_page> createState() => _home_main_pageState();
}

class _home_main_pageState extends State<home_main_page> {
  late Stream slides;

  Stream queryDb()  {
    slides = FirebaseFirestore.instance
        .collection('projects_slider')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }

  @override
  void initState() {
    queryDb();
    super.initState();
  }

  final PageController controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: slides, builder: (context, AsyncSnapshot snap) {
              List slideList=snap.data.toList();
          if (snap.hasError) {
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return PageView.builder(
            controller: controller,
              itemCount: slideList.length,
              itemBuilder: (context, int index) {
                return _buildStoryPage(slideList[index]);

              });
        }));
  }
  _buildStoryPage(Map data){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data['image'])
        )
      ),
      child: Center(
        child: Text(data['title']),
      ),
    );
  }
}
