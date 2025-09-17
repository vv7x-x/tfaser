import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';

class AppConfig {
  static const String appName = 'تفسير القرآن الكريم';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // Environment
  static const bool isProduction = kReleaseMode;
  static const bool isDevelopment = kDebugMode;
  
  // API Configuration
  static const String quranApiUrl = ApiConstants.quranBaseUrl;
  static const String hadithApiUrl = ApiConstants.hadithBaseUrl;
  static const String qiblaApiUrl = ApiConstants.qiblaBaseUrl;
  static const String geocodingApiUrl = ApiConstants.geocodingBaseUrl;
  
  // Cache Configuration
  static const bool enableCaching = true;
  static const int cacheMaxAge = 24 * 60 * 60; // 24 hours in seconds
  
  // Network Configuration
  static const int connectionTimeout = ApiConstants.connectionTimeout;
  static const int receiveTimeout = ApiConstants.receiveTimeout;
  static const int maxRetries = 3;
  
  // UI Configuration
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 8.0;
  static const double largeRadius = 12.0;
  
  // Animation Configuration
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Pagination Configuration
  static const int defaultPageSize = ApiConstants.defaultPageSize;
  static const int maxPageSize = ApiConstants.maxPageSize;
  
  // Feature Flags
  static const bool enableQuranSearch = true;
  static const bool enableHadithSearch = true;
  static const bool enableQiblaCompass = true;
  static const bool enableTasbihCounter = true;
  static const bool enableBookmarks = true;
  static const bool enableOfflineMode = false; // Will be implemented later
  
  // Debug Configuration
  static const bool enableLogging = isDevelopment;
  static const bool enableCrashReporting = isProduction;
  static const bool enableAnalytics = isProduction;
  
  // Localization Configuration
  static const String defaultLanguage = 'ar';
  static const List<String> supportedLanguages = ['ar', 'en'];
  
  // Theme Configuration
  static const String defaultTheme = 'system'; // 'light', 'dark', 'system'
  static const bool enableDynamicColors = true;
  
  // Storage Configuration
  static const String hiveBoxName = 'quran_tafsir_app';
  static const String preferencesKey = 'app_preferences';
  
  // Security Configuration
  static const bool enableCertificatePinning = isProduction;
  static const bool enableDataEncryption = true;
  
  // Performance Configuration
  static const int imageCacheSize = 100;
  static const int textCacheSize = 50;
  static const bool enableImageCompression = true;
  
  // Notification Configuration
  static const bool enablePrayerTimeNotifications = true;
  static const bool enableDailyHadithNotifications = true;
  static const bool enableQuranReminderNotifications = true;
  
  // Backup Configuration
  static const bool enableCloudBackup = false; // Will be implemented later
  static const bool enableLocalBackup = true;
  
  // Update Configuration
  static const bool enableAutoUpdate = false;
  static const String updateCheckUrl = 'https://api.github.com/repos/your-repo/releases/latest';
  
  // Social Configuration
  static const bool enableSharing = true;
  static const bool enableRating = true;
  static const String appStoreUrl = 'https://apps.apple.com/app/your-app';
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=your.package.name';
  
  // Privacy Configuration
  static const bool enableAnalytics = isProduction;
  static const bool enableCrashReporting = isProduction;
  static const bool enableUserTracking = false;
  static const String privacyPolicyUrl = 'https://your-website.com/privacy';
  static const String termsOfServiceUrl = 'https://your-website.com/terms';
  
  // Support Configuration
  static const String supportEmail = 'support@your-website.com';
  static const String supportWebsite = 'https://your-website.com/support';
  static const String feedbackEmail = 'feedback@your-website.com';
  
  // API Keys (These should be stored securely in production)
  static const String? googleMapsApiKey = null; // Add your API key here
  static const String? firebaseApiKey = null; // Add your API key here
  static const String? analyticsApiKey = null; // Add your API key here
}
