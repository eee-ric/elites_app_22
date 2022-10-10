import 'dart:convert';
FacilitiesList facilitiesListFromJson(String str) => FacilitiesList.fromJson(json.decode(str));

String facilitiesListToJson(FacilitiesList data) => json.encode(data.toJson());

class FacilitiesList {
  FacilitiesList({
    required this.facilitiesFrontImage,
    required this.facilitiesFrontTitle,
    required this.facilitiesDetailText,
  });

  String facilitiesFrontImage;
  String facilitiesFrontTitle;
  String facilitiesDetailText;

  factory FacilitiesList.fromJson(Map<String, dynamic> json) => FacilitiesList(
    facilitiesFrontImage: json["facilities_front_image"],
    facilitiesFrontTitle: json["facilities_front_title"],
    facilitiesDetailText: json["facilities_detail"],
  );

  Map<String, dynamic> toJson() => {
    "facilities_front_image": facilitiesFrontImage,
    "facilities_front_title": facilitiesFrontTitle,
    "facilities_detail": facilitiesDetailText,
  };
}
