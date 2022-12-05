import 'dart:convert';

InternshipList internshipListFromJson(String str) => InternshipList.fromJson(json.decode(str));

String internshipListToJson(InternshipList data) => json.encode(data.toJson());

class InternshipList {
  InternshipList({
    required this.internshipImage,
    required this.internshipVideo,
    required this.internshipStep,
    required this.internshipStepDes,
  });

  String internshipImage;
  String internshipVideo;
  String internshipStep;
  String internshipStepDes;

  factory InternshipList.fromJson(Map<String, dynamic> json) => InternshipList(
    internshipImage: json["internship_image"],
    internshipVideo: json["internship_video"],
    internshipStep: json["internship_step"],
    internshipStepDes: json["internship_step_des"],
  );

  Map<String, dynamic> toJson() => {
    "internship_image": internshipImage,
    "internship_video": internshipVideo,
    "internship_step": internshipStep,
    "internship_step_des": internshipStepDes,
  };
}
