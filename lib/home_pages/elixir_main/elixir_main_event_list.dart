import 'dart:convert';

ElixirMainEventList elixirMainEventListFromJson(String str) => ElixirMainEventList.fromJson(json.decode(str));

String elixirMainEventListToJson(ElixirMainEventList data) => json.encode(data.toJson());

class ElixirMainEventList {
  ElixirMainEventList({
    required this.elixirMainEventImage,
    required this.elixirMainEventTitle,
    required this.elixirMainEventVenue,
    required this.elixirMainEventTime,
    required this.elixirMainEventDescription,
    required this.elixirMainEventContact,
  });

  String elixirMainEventImage;
  String elixirMainEventTitle;
  String elixirMainEventVenue;
  String elixirMainEventTime;
  String elixirMainEventDescription;
  String elixirMainEventContact;


  factory ElixirMainEventList.fromJson(Map<String, dynamic> json) => ElixirMainEventList(
    elixirMainEventImage: json["elixir_event_image"],
    elixirMainEventTitle: json["elixir_event_title"],
    elixirMainEventVenue: json["elixir_event_venue"],
    elixirMainEventTime: json["elixir_event_time"],
    elixirMainEventDescription: json["elixir_event_description"],
    elixirMainEventContact: json["elixir_event_contact"],
  );

  Map<String, dynamic> toJson() => {
    "elixir_event_image": elixirMainEventImage,
    "elixir_event_title": elixirMainEventTitle,
    "elixir_event_venue": elixirMainEventVenue,
    "elixir_event_time": elixirMainEventTime,
    "elixir_event_description": elixirMainEventDescription,
    "elixir_event_contact": elixirMainEventContact,
  };
}
