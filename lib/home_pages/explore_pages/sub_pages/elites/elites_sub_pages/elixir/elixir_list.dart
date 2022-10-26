import 'dart:convert';

ElixirList elixirListFromJson(String str) => ElixirList.fromJson(json.decode(str));

String elixirListToJson(ElixirList data) => json.encode(data.toJson());

class ElixirList {
  ElixirList({
    required this.elixirImage,
    required this.elixirTitle,
    required this.elixirImageGallery,
  });

  String elixirImage;
  String elixirTitle;
  String elixirImageGallery;

  factory ElixirList.fromJson(Map<String, dynamic> json) => ElixirList(
    elixirImage: json["elixir_image"],
    elixirTitle: json["elixir_title"],
    elixirImageGallery: json["elixir_image_gallery"],
  );

  Map<String, dynamic> toJson() => {
    "elixir_image": elixirImage,
    "elixir_title": elixirTitle,
    "elixir_image_gallery": elixirImageGallery,
  };
}
