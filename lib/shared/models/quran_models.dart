import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String arabicName;
  final int ayahCount;
  final String revelationType;
  final int revelationOrder;
  final List<Ayah> ayahs;

  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.arabicName,
    required this.ayahCount,
    required this.revelationType,
    required this.revelationOrder,
    required this.ayahs,
  });

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        arabicName,
        ayahCount,
        revelationType,
        revelationOrder,
        ayahs,
      ];

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'] ?? 0,
      name: json['name'] ?? json['englishName'] ?? '',
      englishName: json['englishName'] ?? '',
      arabicName: json['name'] ?? '',
      ayahCount: json['numberOfAyahs'] ?? json['ayahCount'] ?? 0,
      revelationType: json['revelationType'] ?? '',
      revelationOrder: json['revelationOrder'] ?? 0,
      ayahs: (json['ayahs'] as List<dynamic>?)
              ?.map((ayah) => Ayah.fromJson(ayah))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'arabicName': arabicName,
      'ayahCount': ayahCount,
      'revelationType': revelationType,
      'revelationOrder': revelationOrder,
      'ayahs': ayahs.map((ayah) => ayah.toJson()).toList(),
    };
  }
}

class Ayah extends Equatable {
  final int number;
  final String text;
  final String translation;
  final String transliteration;
  final int juz;
  final int hizb;
  final int page;
  final int ruku;
  final int manzil;

  const Ayah({
    required this.number,
    required this.text,
    required this.translation,
    required this.transliteration,
    required this.juz,
    required this.hizb,
    required this.page,
    required this.ruku,
    required this.manzil,
  });

  @override
  List<Object?> get props => [
        number,
        text,
        translation,
        transliteration,
        juz,
        hizb,
        page,
        ruku,
        manzil,
      ];

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['numberInSurah'] ?? json['number'] ?? 0,
      text: json['text'] ?? '',
      translation: json['translation'] ?? '',
      transliteration: json['transliteration'] ?? '',
      juz: json['juz'] ?? 0,
      hizb: json['hizb'] ?? 0,
      page: json['page'] ?? 0,
      ruku: json['ruku'] ?? 0,
      manzil: json['manzil'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'translation': translation,
      'transliteration': transliteration,
      'juz': juz,
      'hizb': hizb,
      'page': page,
      'ruku': ruku,
      'manzil': manzil,
    };
  }
}

class Bookmark extends Equatable {
  final String id;
  final String type; // 'ayah', 'hadith', 'tasbih'
  final String title;
  final String content;
  final DateTime createdAt;
  final String? surahName;
  final int? ayahNumber;

  const Bookmark({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.createdAt,
    this.surahName,
    this.ayahNumber,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        content,
        createdAt,
        surahName,
        ayahNumber,
      ];

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      surahName: json['surahName'],
      ayahNumber: json['ayahNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'surahName': surahName,
      'ayahNumber': ayahNumber,
    };
  }
}
