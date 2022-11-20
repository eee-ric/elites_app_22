import 'dart:convert';

Notify notifyListFromJson(String str) => Notify.fromJson(json.decode(str));

String notifyListToJson(Notify data) => json.encode(data.toJson());

class Notify {
  Notify({
    required this.notifyName,
    required this.notifyDescription1,
    required this.notifyDescription2,
  });

  String notifyName;
  String notifyDescription1;
  String notifyDescription2;

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
    notifyName: json["notify_name"],
    notifyDescription1: json["notify_description1"],
    notifyDescription2: json["notify_description2"],
  );

  Map<String, dynamic> toJson() => {
    "explore_image": notifyName,
    "notify_description1": notifyDescription1,
    "notify_description2": notifyDescription2,
  };
}
