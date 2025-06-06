import 'package:flutter/material.dart';

class TabBarDataModel {
  String id;
  String title;
  Icon icon;
  String? imagePath;
  TabBarDataModel({
    required this.id,
    required this.title,
    required this.icon,
     this.imagePath,
  });
}
