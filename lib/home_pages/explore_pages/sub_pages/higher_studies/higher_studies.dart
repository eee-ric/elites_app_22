import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../elites/elites_sub_pages/elixir/firebase_api.dart';
import '../elites/elites_sub_pages/elixir/firebase_file.dart';

class higher_studies_less extends StatelessWidget {
  const higher_studies_less({Key? key}) : super(key: key);
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Higher Studies'),
        backgroundColor: blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: higher_studies_full(),
    );
  }
}

class higher_studies_full extends StatefulWidget {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  State<higher_studies_full> createState() => _higher_studies_fullstate();
}

class _higher_studies_fullstate extends State<higher_studies_full> {
  late Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String folderName = 'higher_studies/';
    futureFiles = FirebaseApi.listAll(folderName);
  }
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!;
            return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return loadFile(context, file);
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('error occurred'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget loadFile(BuildContext context, FirebaseFile file) =>
      CachedNetworkImage(
        imageUrl: file.url,
        imageBuilder: (context, imageProvider) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(blue),
        )),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
}
