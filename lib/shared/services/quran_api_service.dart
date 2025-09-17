import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/quran_models.dart';

class QuranApiService {
  static final QuranApiService _instance = QuranApiService._internal();
  factory QuranApiService() => _instance;
  QuranApiService._internal();

  late final Dio _dio;
  late final Logger _logger;

  void initialize() {
    _logger = Logger();
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.alquran.cloud/v1',
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

  // Get all surahs
  Future<List<Surah>> getSurahs() async {
    try {
      final response = await _dio.get('/surah');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((surah) => Surah.fromJson(surah)).toList();
      } else {
        throw Exception('Failed to load surahs');
      }
    } on DioException catch (e) {
      _logger.e('Error loading surahs: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading surahs: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get specific surah with ayahs
  Future<Surah> getSurah(int surahNumber) async {
    try {
      final response = await _dio.get('/surah/$surahNumber');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Surah.fromJson(data);
      } else {
        throw Exception('Failed to load surah');
      }
    } on DioException catch (e) {
      _logger.e('Error loading surah: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading surah: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get specific ayah
  Future<Ayah> getAyah(int surahNumber, int ayahNumber) async {
    try {
      final response = await _dio.get('/ayah/$surahNumber:$ayahNumber');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Ayah.fromJson(data);
      } else {
        throw Exception('Failed to load ayah');
      }
    } on DioException catch (e) {
      _logger.e('Error loading ayah: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading ayah: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Search in Quran
  Future<List<Ayah>> searchQuran(String query) async {
    try {
      final response = await _dio.get('/search/$query');
      
      if (response.statusCode == 200) {
        final data = response.data['data']['matches'] as List;
        return data.map((ayah) => Ayah.fromJson(ayah)).toList();
      } else {
        throw Exception('Failed to search Quran');
      }
    } on DioException catch (e) {
      _logger.e('Error searching Quran: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error searching Quran: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get Juz (Para)
  Future<List<Surah>> getJuz(int juzNumber) async {
    try {
      final response = await _dio.get('/juz/$juzNumber');
      
      if (response.statusCode == 200) {
        final data = response.data['data']['surahs'] as List;
        return data.map((surah) => Surah.fromJson(surah)).toList();
      } else {
        throw Exception('Failed to load juz');
      }
    } on DioException catch (e) {
      _logger.e('Error loading juz: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading juz: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get Hizb
  Future<List<Surah>> getHizb(int hizbNumber) async {
    try {
      final response = await _dio.get('/hizb/$hizbNumber');
      
      if (response.statusCode == 200) {
        final data = response.data['data']['surahs'] as List;
        return data.map((surah) => Surah.fromJson(surah)).toList();
      } else {
        throw Exception('Failed to load hizb');
      }
    } on DioException catch (e) {
      _logger.e('Error loading hizb: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading hizb: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get page
  Future<List<Surah>> getPage(int pageNumber) async {
    try {
      final response = await _dio.get('/page/$pageNumber');
      
      if (response.statusCode == 200) {
        final data = response.data['data']['surahs'] as List;
        return data.map((surah) => Surah.fromJson(surah)).toList();
      } else {
        throw Exception('Failed to load page');
      }
    } on DioException catch (e) {
      _logger.e('Error loading page: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading page: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Get translations
  Future<List<Map<String, dynamic>>> getTranslations() async {
    try {
      final response = await _dio.get('/edition');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load translations');
      }
    } on DioException catch (e) {
      _logger.e('Error loading translations: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error loading translations: $e');
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
