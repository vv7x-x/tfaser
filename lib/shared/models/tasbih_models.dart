import 'package:equatable/equatable.dart';

class Tasbih extends Equatable {
  final String id;
  final String name;
  final String arabicText;
  final String translation;
  final String transliteration;
  final int count;
  final String category;
  final bool isDefault;

  const Tasbih({
    required this.id,
    required this.name,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    required this.count,
    required this.category,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        arabicText,
        translation,
        transliteration,
        count,
        category,
        isDefault,
      ];

  factory Tasbih.fromJson(Map<String, dynamic> json) {
    return Tasbih(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      arabicText: json['arabicText'] ?? '',
      translation: json['translation'] ?? '',
      transliteration: json['transliteration'] ?? '',
      count: json['count'] ?? 0,
      category: json['category'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'arabicText': arabicText,
      'translation': translation,
      'transliteration': transliteration,
      'count': count,
      'category': category,
      'isDefault': isDefault,
    };
  }
}

class TasbihSession extends Equatable {
  final String id;
  final String tasbihId;
  final int currentCount;
  final int targetCount;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isCompleted;

  const TasbihSession({
    required this.id,
    required this.tasbihId,
    required this.currentCount,
    required this.targetCount,
    required this.startTime,
    this.endTime,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        tasbihId,
        currentCount,
        targetCount,
        startTime,
        endTime,
        isCompleted,
      ];

  factory TasbihSession.fromJson(Map<String, dynamic> json) {
    return TasbihSession(
      id: json['id'] ?? '',
      tasbihId: json['tasbihId'] ?? '',
      currentCount: json['currentCount'] ?? 0,
      targetCount: json['targetCount'] ?? 0,
      startTime: DateTime.parse(json['startTime'] ?? DateTime.now().toIso8601String()),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tasbihId': tasbihId,
      'currentCount': currentCount,
      'targetCount': targetCount,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}

class TasbihCategory extends Equatable {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String color;

  const TasbihCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  List<Object?> get props => [id, name, description, icon, color];

  factory TasbihCategory.fromJson(Map<String, dynamic> json) {
    return TasbihCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      color: json['color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'color': color,
    };
  }
}
