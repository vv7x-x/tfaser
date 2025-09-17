import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/hadith_models.dart';

class HadithApiService {
  static final HadithApiService _instance = HadithApiService._internal();
  factory HadithApiService() => _instance;
  HadithApiService._internal();

  late final Dio _dio;
  late final Logger _logger;

  void initialize() {
    _logger = Logger();
    _dio = Dio(BaseOptions(
      baseUrl: 'https://hadithapi.com/api',
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

  // Get all hadiths
  Future<List<Hadith>> getHadiths({
    int page = 1,
    int limit = 20,
    String? category,
    String? source,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (category != null) queryParams['category'] = category;
      if (source != null) queryParams['source'] = source;

      final response = await _dio.get('/hadiths', queryParameters: queryParams);
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((hadith) => Hadith.fromJson(hadith)).toList();
      } else {
        throw Exception('Failed to load hadiths');
      }
    } on DioException catch (e) {
      _logger.e('Error loading hadiths: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading hadiths: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get specific hadith
  Future<Hadith> getHadith(String hadithId) async {
    try {
      final response = await _dio.get('/hadiths/$hadithId');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Hadith.fromJson(data);
      } else {
        throw Exception('Failed to load hadith');
      }
    } on DioException catch (e) {
      _logger.e('Error loading hadith: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading hadith: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Search hadiths
  Future<List<Hadith>> searchHadiths(String query) async {
    try {
      final response = await _dio.get('/hadiths/search', queryParameters: {
        'q': query,
      });
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((hadith) => Hadith.fromJson(hadith)).toList();
      } else {
        throw Exception('Failed to search hadiths');
      }
    } on DioException catch (e) {
      _logger.e('Error searching hadiths: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error searching hadiths: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get hadith categories
  Future<List<HadithCategory>> getCategories() async {
    try {
      final response = await _dio.get('/categories');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((category) => HadithCategory.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } on DioException catch (e) {
      _logger.e('Error loading categories: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading categories: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get hadith sources
  Future<List<HadithSource>> getSources() async {
    try {
      final response = await _dio.get('/sources');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((source) => HadithSource.fromJson(source)).toList();
      } else {
        throw Exception('Failed to load sources');
      }
    } on DioException catch (e) {
      _logger.e('Error loading sources: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading sources: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get random hadith
  Future<Hadith> getRandomHadith() async {
    try {
      final response = await _dio.get('/hadiths/random');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Hadith.fromJson(data);
      } else {
        throw Exception('Failed to load random hadith');
      }
    } on DioException catch (e) {
      _logger.e('Error loading random hadith: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading random hadith: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get hadiths by narrator
  Future<List<Hadith>> getHadithsByNarrator(String narrator) async {
    try {
      final response = await _dio.get('/hadiths/narrator/$narrator');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((hadith) => Hadith.fromJson(hadith)).toList();
      } else {
        throw Exception('Failed to load hadiths by narrator');
      }
    } on DioException catch (e) {
      _logger.e('Error loading hadiths by narrator: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading hadiths by narrator: $e');
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
