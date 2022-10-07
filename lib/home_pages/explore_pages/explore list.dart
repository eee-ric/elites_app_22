import 'dart:convert';

ExploreList exploreListFromJson(String str) => ExploreList.fromJson(json.decode(str));

String exploreListToJson(ExploreList data) => json.encode(data.toJson());

class ExploreList {
  ExploreList({
    required this.exploreImage,
    required this.exploreTitle,
  });

  String exploreImage;
  String exploreTitle;

  factory ExploreList.fromJson(Map<String, dynamic> json) => ExploreList(
    exploreImage: json["explore_image"],
    exploreTitle: json["explore_title"],
  );

  Map<String, dynamic> toJson() => {
    "explore_image": exploreImage,
    "explore_title": exploreTitle,
  };
}
