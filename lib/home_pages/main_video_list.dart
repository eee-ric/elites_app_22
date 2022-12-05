import 'dart:convert';

TeaserVideoLink videoLinkFromJson(String str) => TeaserVideoLink.fromJson(json.decode(str));

String videoLinkToJson(TeaserVideoLink data) => json.encode(data.toJson());

class TeaserVideoLink {
  TeaserVideoLink({
    required this.teaserVideoLink,
  });

  String teaserVideoLink;

  factory TeaserVideoLink.fromJson(Map<String, dynamic> json) => TeaserVideoLink(
    teaserVideoLink: json["video_link"],
  );

  Map<String, dynamic> toJson() => {
    "video_link": teaserVideoLink,
  };
}
