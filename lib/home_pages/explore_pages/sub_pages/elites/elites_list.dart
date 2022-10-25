import 'dart:convert';

ElitesList elitesListFromJson(String str) => ElitesList.fromJson(json.decode(str));

String elitesListToJson(ElitesList data) => json.encode(data.toJson());

class ElitesList {
  ElitesList({
    required this.elitesImage,
    required this.elitesTitle,
  });

  String elitesImage;
  String elitesTitle;

  factory ElitesList.fromJson(Map<String, dynamic> json) => ElitesList(
    elitesImage: json["elites_image"],
    elitesTitle: json["elites_title"],
  );

  Map<String, dynamic> toJson() => {
    "elites_image": elitesImage,
    "elites_title": elitesTitle,
  };
}
