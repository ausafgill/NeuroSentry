import 'package:flutter/material.dart';

class ConsultantModel {
  final String name;
  final String type;
  final String description;
  Color color;

  ConsultantModel({
    required this.name,
    required this.type,
    required this.description,
    this.color = Colors.blue,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'color': color.value,
    };
  }

  factory ConsultantModel.fromMap(Map<String, dynamic> map) {
    return ConsultantModel(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      color: Color(map['color']),
    );
  }
}
