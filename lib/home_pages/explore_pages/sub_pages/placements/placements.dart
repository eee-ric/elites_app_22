import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../elites/elites_sub_pages/elixir/firebase_api.dart';
import '../elites/elites_sub_pages/elixir/firebase_file.dart';

class placement_less extends StatelessWidget {
  const placement_less({Key? key}) : super(key: key);
  final blue = const Color.fromRGBO(0, 0, 153, 30);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(255, 216, 0, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placements'),
        backgroundColor: blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: placement_full(),
    );
  }
}

class placement_full extends StatefulWidget {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  State<placement_full> createState() => _placement_fullState();
}

class _placement_fullState extends State<placement_full> {
  late Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String folderName = 'placements/';
    futureFiles = FirebaseApi.listAll(folderName);
  }
  final blue = const Color.fromRGBO(0, 0, 153, 30);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(255, 216, 0, 50);
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
