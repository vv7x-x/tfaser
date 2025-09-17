import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/qibla_models.dart';

class QiblaApiService {
  static final QiblaApiService _instance = QiblaApiService._internal();
  factory QiblaApiService() => _instance;
  QiblaApiService._internal();

  late final Dio _dio;
  late final Logger _logger;

  // Kaaba coordinates
  static const double kaabaLat = 21.4225;
  static const double kaabaLng = 39.8262;

  void initialize() {
    _logger = Logger();
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.aladhan.com/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => _logger.d(object),
    ));
  }

  // Calculate Qibla direction
  Future<QiblaDirection> calculateQiblaDirection({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get('/qibla/$latitude/$longitude');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return QiblaDirection.fromJson(data);
      } else {
        throw Exception('Failed to calculate Qibla direction');
      }
    } on DioException catch (e) {
      _logger.e('Error calculating Qibla direction: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error calculating Qibla direction: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get Qibla direction for a city
  Future<QiblaDirection> getQiblaDirectionForCity(String city) async {
    try {
      final response = await _dio.get('/qibla/$city');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return QiblaDirection.fromJson(data);
      } else {
        throw Exception('Failed to get Qibla direction for city');
      }
    } on DioException catch (e) {
      _logger.e('Error getting Qibla direction for city: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error getting Qibla direction for city: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get prayer times for location
  Future<Map<String, dynamic>> getPrayerTimes({
    required double latitude,
    required double longitude,
    int? month,
    int? year,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
      };

      if (month != null) queryParams['month'] = month;
      if (year != null) queryParams['year'] = year;

      final response = await _dio.get('/timings', queryParameters: queryParams);
      
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to get prayer times');
      }
    } on DioException catch (e) {
      _logger.e('Error getting prayer times: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error getting prayer times: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get current prayer time
  Future<Map<String, dynamic>> getCurrentPrayerTime({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get('/timings', queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
      });
      
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to get current prayer time');
      }
    } on DioException catch (e) {
      _logger.e('Error getting current prayer time: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error getting current prayer time: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Calculate distance to Kaaba
  double calculateDistanceToKaaba(double latitude, double longitude) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final double lat1Rad = latitude * (3.14159265359 / 180);
    final double lat2Rad = kaabaLat * (3.14159265359 / 180);
    final double deltaLatRad = (kaabaLat - latitude) * (3.14159265359 / 180);
    final double deltaLngRad = (kaabaLng - longitude) * (3.14159265359 / 180);

    final double a = (deltaLatRad / 2).sin() * (deltaLatRad / 2).sin() +
        lat1Rad.cos() * lat2Rad.cos() *
        (deltaLngRad / 2).sin() * (deltaLngRad / 2).sin();
    final double c = 2 * (a.sqrt()).asin();

    return earthRadius * c;
  }

  // Calculate Qibla angle
  double calculateQiblaAngle(double latitude, double longitude) {
    final double lat1Rad = latitude * (3.14159265359 / 180);
    final double lat2Rad = kaabaLat * (3.14159265359 / 180);
    final double deltaLngRad = (kaabaLng - longitude) * (3.14159265359 / 180);

    final double y = deltaLngRad.sin() * lat2Rad.cos();
    final double x = lat1Rad.cos() * lat2Rad.sin() -
        lat1Rad.sin() * lat2Rad.cos() * deltaLngRad.cos();

    double bearing = (y.atan2(x) * 180 / 3.14159265359);
    if (bearing < 0) bearing += 360;

    return bearing;
  }

  // Get location from coordinates (reverse geocoding)
  Future<Location> getLocationFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.bigdatacloud.net/data/reverse-geocode-client',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'localityLanguage': 'ar',
        },
      );
      
      if (response.statusCode == 200) {
        final data = response.data;
        return Location(
          latitude: latitude,
          longitude: longitude,
          city: data['city'] ?? 'غير محدد',
          country: data['countryName'] ?? 'غير محدد',
          address: data['locality'] ?? 'غير محدد',
          timestamp: DateTime.now(),
        );
      } else {
        throw Exception('Failed to get location from coordinates');
      }
    } on DioException catch (e) {
      _logger.e('Error getting location from coordinates: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error getting location from coordinates: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('انتهت مهلة الاتصال');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'خطأ في الخادم';
        return Exception('$message (كود: $statusCode)');
      case DioExceptionType.cancel:
        return Exception('تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return Exception('خطأ في الاتصال');
      default:
        return Exception(e.message ?? 'خطأ غير معروف');
    }
  }
}
