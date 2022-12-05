import 'dart:convert';

InvitationVideoList invitationVideoListFromJson(String str) => InvitationVideoList.fromJson(json.decode(str));

String invitationVideoListListToJson(InvitationVideoList data) => json.encode(data.toJson());

class InvitationVideoList {
  InvitationVideoList({
    required this.invitationVideo,

  });

  String invitationVideo;


  factory InvitationVideoList.fromJson(Map<String, dynamic> json) => InvitationVideoList(
    invitationVideo: json["invitation_video"],

  );

  Map<String, dynamic> toJson() => {
    "invitation_video": invitationVideo,

  };
}
