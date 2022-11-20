import 'dart:convert';

RicProjectList ricProjectListFromJson(String str) => RicProjectList.fromJson(json.decode(str));

String ricProjectListListToJson(RicProjectList data) => json.encode(data.toJson());

class RicProjectList {
  RicProjectList({
    required this.elixirProjectListImage,
    required this.elixirProjectListName,
    required this.elixirProjectListDescription,
    required this.elixirProjectListVideo,
  });

  String elixirProjectListImage;
  String elixirProjectListName;
  String elixirProjectListDescription;
  String elixirProjectListVideo;

  factory RicProjectList.fromJson(Map<String, dynamic> json) => RicProjectList(
    elixirProjectListImage: json["ric_project_image"],
    elixirProjectListName: json["ric_project_name"],
    elixirProjectListDescription: json["ric_project_description"],
    elixirProjectListVideo: json["ric_project_video"],
  );

  Map<String, dynamic> toJson() => {
    "ric_project_image": elixirProjectListImage,
    "ric_project_name": elixirProjectListName,
    "ric_project_description": elixirProjectListDescription,
    "ric_project_video": elixirProjectListVideo,
  };
}
