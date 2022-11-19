import 'dart:convert';

ShareLinkList shareListFromJson(String str) =>
    ShareLinkList.fromJson(json.decode(str));

String shareListListToJson(ShareLinkList data) => json.encode(data.toJson());

class ShareLinkList {
  ShareLinkList({
    required this.link,
  });

  String link;

  factory ShareLinkList.fromJson(Map<String, dynamic> json) => ShareLinkList(
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
      };
}
