class ApiConstants {
  // Quran API
  static const String quranBaseUrl = 'https://api.alquran.cloud/v1';
  static const String quranSearchUrl = 'https://api.alquran.cloud/v1/search';
  
  // Hadith API
  static const String hadithBaseUrl = 'https://hadithapi.com/api';
  
  // Qibla API
  static const String qiblaBaseUrl = 'https://api.aladhan.com/v1';
  static const String geocodingBaseUrl = 'https://api.bigdatacloud.net/data/reverse-geocode-client';
  
  // Kaaba coordinates
  static const double kaabaLatitude = 21.4225;
  static const double kaabaLongitude = 39.8262;
  
  // API Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache durations
  static const int surahsCacheDuration = 24 * 60 * 60 * 1000; // 24 hours
  static const int hadithsCacheDuration = 12 * 60 * 60 * 1000; // 12 hours
  static const int qiblaCacheDuration = 60 * 60 * 1000; // 1 hour
  
  // API Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'QuranTafsirApp/1.0.0',
  };
  
  // Error messages
  static const String networkErrorMessage = 'خطأ في الاتصال بالشبكة';
  static const String timeoutErrorMessage = 'انتهت مهلة الاتصال';
  static const String serverErrorMessage = 'خطأ في الخادم';
  static const String unknownErrorMessage = 'حدث خطأ غير متوقع';
}
