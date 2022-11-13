import 'dart:convert';

ElixirProjectList elixirProjectListFromJson(String str) => ElixirProjectList.fromJson(json.decode(str));

String elixirProjectListListToJson(ElixirProjectList data) => json.encode(data.toJson());

class ElixirProjectList {
  ElixirProjectList({
    required this.elixirProjectListImage,
    required this.elixirProjectListName,
    required this.elixirProjectListDescription,
    required this.elixirProjectListVideo,
  });

  String elixirProjectListImage;
  String elixirProjectListName;
  String elixirProjectListDescription;
  String elixirProjectListVideo;

  factory ElixirProjectList.fromJson(Map<String, dynamic> json) => ElixirProjectList(
    elixirProjectListImage: json["elixir_project_image"],
    elixirProjectListName: json["elixir_project_name"],
    elixirProjectListDescription: json["elixir_project_description"],
    elixirProjectListVideo: json["elixir_project_video"],
  );

  Map<String, dynamic> toJson() => {
    "elixir_project_image": elixirProjectListImage,
    "elixir_project_name": elixirProjectListName,
    "elixir_project_description": elixirProjectListDescription,
    "elixir_project_video": elixirProjectListVideo,
  };
}
