import 'dart:convert';

Live liveListFromJson(String str) => Live.fromJson(json.decode(str));

String liveListToJson(Live data) => json.encode(data.toJson());

class Live {
  Live({
    required this.live,
  });

  String live;

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        live: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "link": live,
      };
}
