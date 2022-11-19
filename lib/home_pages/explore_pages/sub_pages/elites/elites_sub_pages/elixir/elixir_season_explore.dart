import 'package:cached_network_image/cached_network_image.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_sub_pages/elixir/elixir_list.dart';
import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_sub_pages/elixir/firebase_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_file.dart';

class elixir_season_explore extends StatelessWidget {
  final ElixirList elixirList;

  const elixir_season_explore(this.elixirList);
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(elixirList.elixirTitle),
        backgroundColor: blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: elixir_season_image(elixirList),
    );
  }
}

class elixir_season_image extends StatefulWidget {
  final ElixirList elixirList;

  const elixir_season_image(this.elixirList);

  @override
  State<elixir_season_image> createState() {
    return _elixir_season_imageState(elixirList);
  }
}

class _elixir_season_imageState extends State<elixir_season_image> {
  late final ElixirList elixirList;
  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);

  _elixir_season_imageState(this.elixirList);

  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    // futureFiles =
    //     FirebaseStorage.instance.ref(elixirList.elixirImageGallery).listAll();
    String folderName = '${elixirList.elixirImageGallery}/';
    futureFiles = FirebaseApi.listAll(folderName);
  }

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
            aspectRatio:16/9 ,
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
