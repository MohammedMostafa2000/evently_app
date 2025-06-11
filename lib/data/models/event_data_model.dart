import 'package:cloud_firestore/cloud_firestore.dart';

class EventDataModel {
  final String title;
  final String description;
  final String categoryID;
  final String eventID;
  final DateTime dateTime;
  final Map<String, int> time;
  final double? lat;
  final double? lng;

  final String userID;

  EventDataModel({
    required this.userID,
    required this.eventID,
    required this.title,
    required this.description,
    required this.categoryID,
    required this.dateTime,
    required this.time,
    this.lat = 0,
    this.lng = 0,
  });

  Map<String, dynamic> toJson(String eventID) => {
        'title': title,
        'description': description,
        'categoryID': categoryID,
        'eventID': eventID,
        'date': dateTime,
        'time': time,
        'lat': lat,
        'lng': lng,
        'userID': userID,
      };

  factory EventDataModel.fromJson(Map<String, dynamic> json) => EventDataModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        categoryID: json['categoryID'] ?? '',
        eventID: json['eventID'] ?? '',
        dateTime: (json['date'] as Timestamp).toDate(),
        time: Map<String, int>.from(json['time'] ?? {'hour': 0, 'minute': 0}),
        lat: json['lat'],
        lng: json['lng'],
        userID: json['userID'],
      );
}
