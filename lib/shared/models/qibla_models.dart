import 'package:equatable/equatable.dart';

class QiblaDirection extends Equatable {
  final double latitude;
  final double longitude;
  final double qiblaAngle;
  final double distance;
  final String city;
  final String country;

  const QiblaDirection({
    required this.latitude,
    required this.longitude,
    required this.qiblaAngle,
    required this.distance,
    required this.city,
    required this.country,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        qiblaAngle,
        distance,
        city,
        country,
      ];

  factory QiblaDirection.fromJson(Map<String, dynamic> json) {
    return QiblaDirection(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      qiblaAngle: (json['direction'] ?? json['qiblaAngle'] ?? 0.0).toDouble(),
      distance: (json['distance'] ?? 0.0).toDouble(),
      city: json['city'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'qiblaAngle': qiblaAngle,
      'distance': distance,
      'city': city,
      'country': country,
    };
  }
}

class Location extends Equatable {
  final double latitude;
  final double longitude;
  final String city;
  final String country;
  final String address;
  final DateTime timestamp;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
    required this.address,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        city,
        country,
        address,
        timestamp,
      ];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      address: json['address'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'country': country,
      'address': address,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class CompassReading extends Equatable {
  final double heading;
  final double qiblaAngle;
  final double difference;
  final double accuracy;
  final DateTime timestamp;

  const CompassReading({
    required this.heading,
    required this.qiblaAngle,
    required this.difference,
    required this.accuracy,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        heading,
        qiblaAngle,
        difference,
        accuracy,
        timestamp,
      ];

  factory CompassReading.fromJson(Map<String, dynamic> json) {
    return CompassReading(
      heading: (json['heading'] ?? 0.0).toDouble(),
      qiblaAngle: (json['qiblaAngle'] ?? 0.0).toDouble(),
      difference: (json['difference'] ?? 0.0).toDouble(),
      accuracy: (json['accuracy'] ?? 0.0).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'qiblaAngle': qiblaAngle,
      'difference': difference,
      'accuracy': accuracy,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
