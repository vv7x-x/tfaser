import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class NetworkUtils {
  static final NetworkUtils _instance = NetworkUtils._internal();
  factory NetworkUtils() => _instance;
  NetworkUtils._internal();

  final Connectivity _connectivity = Connectivity();

  /// Check if device has internet connection
  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      }
      
      // Additional check by trying to reach a reliable server
      final result2 = await InternetAddress.lookup('google.com');
      return result2.isNotEmpty && result2[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get current connectivity status
  Future<ConnectivityResult> getConnectivityStatus() async {
    return await _connectivity.checkConnectivity();
  }

  /// Listen to connectivity changes
  Stream<ConnectivityResult> get connectivityStream {
    return _connectivity.onConnectivityChanged;
  }

  /// Handle Dio errors and return user-friendly messages
  String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiConstants.timeoutErrorMessage;
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          if (statusCode >= 500) {
            return ApiConstants.serverErrorMessage;
          } else if (statusCode == 404) {
            return 'المورد غير موجود';
          } else if (statusCode == 401) {
            return 'غير مصرح بالوصول';
          } else if (statusCode == 403) {
            return 'ممنوع الوصول';
          } else if (statusCode >= 400) {
            return 'طلب غير صحيح';
          }
        }
        return ApiConstants.serverErrorMessage;
      
      case DioExceptionType.cancel:
        return 'تم إلغاء الطلب';
      
      case DioExceptionType.connectionError:
        return ApiConstants.networkErrorMessage;
      
      case DioExceptionType.badCertificate:
        return 'خطأ في شهادة الأمان';
      
      case DioExceptionType.unknown:
      default:
        return ApiConstants.unknownErrorMessage;
    }
  }

  /// Check if error is due to network issues
  bool isNetworkError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
           error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           error.type == DioExceptionType.receiveTimeout;
  }

  /// Check if error is due to server issues
  bool isServerError(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      return statusCode != null && statusCode >= 500;
    }
    return false;
  }

  /// Get retry delay based on error type
  Duration getRetryDelay(int attempt) {
    // Exponential backoff: 1s, 2s, 4s, 8s, 16s
    return Duration(seconds: math.pow(2, attempt).toInt());
  }

  /// Check if request should be retried
  bool shouldRetry(DioException error, int attempt) {
    if (attempt >= 3) return false; // Max 3 retries
    
    return isNetworkError(error) || 
           (isServerError(error) && attempt < 2);
  }
}

// Import math for exponential backoff
import 'dart:math' as math;
