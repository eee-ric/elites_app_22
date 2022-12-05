import 'dart:convert';

import 'package:elites_app_22/home_pages/events/events_page.dart';

EventList eventListFromJson(String str) => EventList.fromJson(json.decode(str));

String eventListToJson(EventList data) => json.encode(data.toJson());

class EventList {
  EventList({
    required this.eventPoster,
    required this.eventTitle,
    required this.eventStatus,
    required this.eventDate,
    required this.eventVenue,
    required this.eventContact,
    required this.eventDescription,
  });

  String eventPoster;
  String eventTitle;
  String eventStatus;
  String eventDate;
  String eventVenue;
  String eventContact;
  String eventDescription;

  factory EventList.fromJson(Map<String, dynamic> json) => EventList(
    eventPoster: json["event_poster"],
    eventTitle: json["event_title"],
    eventStatus: json["event_status"],
    eventDate: json["event_date"],
    eventVenue: json["event_venue"],
    eventContact: json["event_contact"],
    eventDescription: json["event_description"],
  );

  Map<String, dynamic> toJson() => {
    "event_poster": eventPoster,
    "event_title": eventTitle,
    "event_status": eventStatus,
    "event_date": eventDate,
    "event_venue": eventVenue,
    "event_contact": eventContact,
    "event_description": eventDescription,
  };
}
