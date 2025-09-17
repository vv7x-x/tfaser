import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/app_state.dart';

class AppService {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  late final Dio _dio;
  late final Logger _logger;
  late final Connectivity _connectivity;

  void initialize() {
    _logger = Logger();
    _connectivity = Connectivity();
    
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
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

  Future<bool> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      _logger.e('Connectivity check failed: $e');
      return false;
    }
  }

  Future<AppState> get(String endpoint) async {
    try {
      final hasConnection = await checkConnectivity();
      if (!hasConnection) {
        return const AppError(message: 'لا يوجد اتصال بالإنترنت');
      }

      final response = await _dio.get(endpoint);
      return AppLoaded(data: response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return AppError(message: 'حدث خطأ غير متوقع');
    }
  }

  Future<AppState> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final hasConnection = await checkConnectivity();
      if (!hasConnection) {
        return const AppError(message: 'لا يوجد اتصال بالإنترنت');
      }

      final response = await _dio.post(endpoint, data: data);
      return AppLoaded(data: response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return AppError(message: 'حدث خطأ غير متوقع');
    }
  }

  AppState _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppError(message: 'انتهت مهلة الاتصال');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'خطأ في الخادم';
        return AppError(message: message, code: statusCode.toString());
      case DioExceptionType.cancel:
        return const AppError(message: 'تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return const AppError(message: 'خطأ في الاتصال');
      default:
        return AppError(message: e.message ?? 'خطأ غير معروف');
    }
  }
}
