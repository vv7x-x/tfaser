import 'package:equatable/equatable.dart';

class Hadith extends Equatable {
  final String id;
  final String title;
  final String arabicText;
  final String translation;
  final String source;
  final String narrator;
  final String grade;
  final String category;
  final List<String> tags;
  final DateTime createdAt;

  const Hadith({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.source,
    required this.narrator,
    required this.grade,
    required this.category,
    required this.tags,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        arabicText,
        translation,
        source,
        narrator,
        grade,
        category,
        tags,
        createdAt,
      ];

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      arabicText: json['arabicText'] ?? '',
      translation: json['translation'] ?? '',
      source: json['source'] ?? '',
      narrator: json['narrator'] ?? '',
      grade: json['grade'] ?? '',
      category: json['category'] ?? '',
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'arabicText': arabicText,
      'translation': translation,
      'source': source,
      'narrator': narrator,
      'grade': grade,
      'category': category,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class HadithCategory extends Equatable {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int hadithCount;

  const HadithCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.hadithCount,
  });

  @override
  List<Object?> get props => [id, name, description, icon, hadithCount];

  factory HadithCategory.fromJson(Map<String, dynamic> json) {
    return HadithCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      hadithCount: json['hadithCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'hadithCount': hadithCount,
    };
  }
}

class HadithSource extends Equatable {
  final String id;
  final String name;
  final String description;
  final String author;
  final int hadithCount;

  const HadithSource({
    required this.id,
    required this.name,
    required this.description,
    required this.author,
    required this.hadithCount,
  });

  @override
  List<Object?> get props => [id, name, description, author, hadithCount];

  factory HadithSource.fromJson(Map<String, dynamic> json) {
    return HadithSource(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      author: json['author'] ?? '',
      hadithCount: json['hadithCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'author': author,
      'hadithCount': hadithCount,
    };
  }
}
