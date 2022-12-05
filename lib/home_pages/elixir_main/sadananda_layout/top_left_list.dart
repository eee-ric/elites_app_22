import 'dart:convert';

TopLeft topLeftListFromJson(String str) => TopLeft.fromJson(json.decode(str));

String topLeftListToJson(TopLeft data) => json.encode(data.toJson());

class TopLeft {
  TopLeft({
    required this.title,
    required this.image,
    required this.video,
    required this.description,
    required this.sl_number,
  });

  String title;
  String image;
  String video;
  String description;
  String sl_number;

  factory TopLeft.fromJson(Map<String, dynamic> json) => TopLeft(
    title: json["title"],
    image: json["image"],
    video: json["video"],
    description: json["description"],
    sl_number: json["sl_number"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "video": video,
    "description": description,
    "sl_number": sl_number,
  };
}
