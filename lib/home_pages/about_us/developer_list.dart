import 'dart:convert';

DeveloperList developerListFromJson(String str) => DeveloperList.fromJson(json.decode(str));

String developerListListToJson(DeveloperList data) => json.encode(data.toJson());

class DeveloperList {
  DeveloperList({
    required this.developerImage,
    required this.developerName,
    required this.developerInsta,
    required this.developerLinkedIn,
    required this.developerMail,
  });

  String developerImage;
  String developerName;
  String developerInsta;
  String developerLinkedIn;
  String developerMail;

  factory DeveloperList.fromJson(Map<String, dynamic> json) => DeveloperList(
    developerImage: json["developer_image"],
    developerName: json["developer_name"],
    developerInsta: json["developer_insta"],
    developerLinkedIn: json["developer_linked_in"],
    developerMail: json["developer_mail"],
  );

  Map<String, dynamic> toJson() => {
    "developer_image": developerImage,
    "developer_name": developerName,
    "developer_insta": developerInsta,
    "developer_linked_in": developerLinkedIn,
    "developer_mail": developerMail,
  };
}
