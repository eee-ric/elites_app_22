import 'package:elites_app_22/home_pages/explore_pages/sub_pages/elites/elites_sub_pages/elixir/elixir_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class elixir_season_explore extends StatelessWidget {
  final ElixirList elixirList;

  elixir_season_explore(this.elixirList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(elixirList.elixirTitle),
        backgroundColor: Color.fromRGBO(103, 0, 1, 20),
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

  elixir_season_image(this.elixirList);

  @override
  State<elixir_season_image> createState() {
    return _elixir_season_imageState(elixirList);
  }
}

class _elixir_season_imageState extends State<elixir_season_image> {
  late final ElixirList elixirList;

  _elixir_season_imageState(this.elixirList);

  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref(elixirList.elixirImageGallery).listAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return ListTile(
                    title: Text(file.name),
                  );
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
}


// class FirebaseApi {
//   static _getDownloadLink(List<Reference> ref) {
//     Future.wait(ref.map((ref) => ref.getDownloadURL()).toList());
//   }
//
//   static Future<List<FirebaseFile>> listAll(String path) async {
//     final ref = FirebaseStorage.instance.ref(path);
//     final result = await ref.listAll();
//     final urls = await _getDownloadLink(result.items);
//     return urls
//         .asMap()
//         .map((index, url) {
//           final ref = result.items[index];
//           final name = ref.name;
//           final file = FirebaseFile(ref: ref, name: name, url: url);
//           return MapEntry(index, file);
//         })
//         .values
//         .toList();
//   }
// }
