import 'dart:convert';

ProjectVideoList projectVideoListFromJson(String str) => ProjectVideoList.fromJson(json.decode(str));

String projectVideoListToJson(ProjectVideoList data) => json.encode(data.toJson());

class ProjectVideoList {
  ProjectVideoList({
    required this.projectImage,
    required this.projectVideo,
    required this.projectName,
    required this.projectDes,
  });

  String projectImage;
  String projectVideo;
  String projectName;
  String projectDes;

  factory ProjectVideoList.fromJson(Map<String, dynamic> json) => ProjectVideoList(
    projectImage: json["project_image"],
    projectVideo: json["project_video"],
    projectName: json["project_name"],
    projectDes: json["project_description"],
  );

  Map<String, dynamic> toJson() => {
    "project_image": projectImage,
    "project_video": projectVideo,
    "project_name": projectName,
    "project_description": projectDes,
  };
}
