import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('ar', ''), // Arabic
    Locale('en', ''), // English
  ];

  // App Info
  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get appSubtitle => _localizedValues[locale.languageCode]!['appSubtitle']!;

  // Navigation
  String get quran => _localizedValues[locale.languageCode]!['quran']!;
  String get tafsir => _localizedValues[locale.languageCode]!['tafsir']!;
  String get bookmarks => _localizedValues[locale.languageCode]!['bookmarks']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get search => _localizedValues[locale.languageCode]!['search']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;

  // General
  String get version => _localizedValues[locale.languageCode]!['version']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;

  // Errors
  String get noInternetConnection => _localizedValues[locale.languageCode]!['noInternetConnection']!;
  String get unexpectedError => _localizedValues[locale.languageCode]!['unexpectedError']!;
  String get connectionTimeout => _localizedValues[locale.languageCode]!['connectionTimeout']!;
  String get serverError => _localizedValues[locale.languageCode]!['serverError']!;
  String get requestCancelled => _localizedValues[locale.languageCode]!['requestCancelled']!;
  String get connectionError => _localizedValues[locale.languageCode]!['connectionError']!;
  String get unknownError => _localizedValues[locale.languageCode]!['unknownError']!;

  // Quran Terms
  String get surah => _localizedValues[locale.languageCode]!['surah']!;
  String get ayah => _localizedValues[locale.languageCode]!['ayah']!;
  String get juz => _localizedValues[locale.languageCode]!['juz']!;
  String get hizb => _localizedValues[locale.languageCode]!['hizb']!;
  String get page => _localizedValues[locale.languageCode]!['page']!;

  // Actions
  String get readMore => _localizedValues[locale.languageCode]!['readMore']!;
  String get bookmark => _localizedValues[locale.languageCode]!['bookmark']!;
  String get removeBookmark => _localizedValues[locale.languageCode]!['removeBookmark']!;
  String get share => _localizedValues[locale.languageCode]!['share']!;
  String get copy => _localizedValues[locale.languageCode]!['copy']!;

  // Settings
  String get fontSize => _localizedValues[locale.languageCode]!['fontSize']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get arabic => _localizedValues[locale.languageCode]!['arabic']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get light => _localizedValues[locale.languageCode]!['light']!;
  String get dark => _localizedValues[locale.languageCode]!['dark']!;
  String get system => _localizedValues[locale.languageCode]!['system']!;
  String get small => _localizedValues[locale.languageCode]!['small']!;
  String get medium => _localizedValues[locale.languageCode]!['medium']!;
  String get large => _localizedValues[locale.languageCode]!['large']!;
  String get extraLarge => _localizedValues[locale.languageCode]!['extraLarge']!;

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'appTitle': 'تفسير القرآن الكريم',
      'appSubtitle': 'تطبيق تفسير القرآن الكريم',
      'quran': 'القرآن',
      'tafsir': 'التفسير',
      'bookmarks': 'المحفوظات',
      'settings': 'الإعدادات',
      'search': 'بحث',
      'about': 'حول التطبيق',
      'version': 'الإصدار',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'retry': 'إعادة المحاولة',
      'noInternetConnection': 'لا يوجد اتصال بالإنترنت',
      'unexpectedError': 'حدث خطأ غير متوقع',
      'connectionTimeout': 'انتهت مهلة الاتصال',
      'serverError': 'خطأ في الخادم',
      'requestCancelled': 'تم إلغاء الطلب',
      'connectionError': 'خطأ في الاتصال',
      'unknownError': 'خطأ غير معروف',
      'surah': 'سورة',
      'ayah': 'آية',
      'juz': 'جزء',
      'hizb': 'حزب',
      'page': 'صفحة',
      'readMore': 'اقرأ المزيد',
      'bookmark': 'إضافة للمحفوظات',
      'removeBookmark': 'إزالة من المحفوظات',
      'share': 'مشاركة',
      'copy': 'نسخ',
      'fontSize': 'حجم الخط',
      'theme': 'المظهر',
      'language': 'اللغة',
      'arabic': 'العربية',
      'english': 'English',
      'light': 'فاتح',
      'dark': 'داكن',
      'system': 'النظام',
      'small': 'صغير',
      'medium': 'متوسط',
      'large': 'كبير',
      'extraLarge': 'كبير جداً',
    },
    'en': {
      'appTitle': 'Quran Tafsir',
      'appSubtitle': 'Quran Tafsir Application',
      'quran': 'Quran',
      'tafsir': 'Tafsir',
      'bookmarks': 'Bookmarks',
      'settings': 'Settings',
      'search': 'Search',
      'about': 'About',
      'version': 'Version',
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'noInternetConnection': 'No internet connection',
      'unexpectedError': 'An unexpected error occurred',
      'connectionTimeout': 'Connection timeout',
      'serverError': 'Server error',
      'requestCancelled': 'Request cancelled',
      'connectionError': 'Connection error',
      'unknownError': 'Unknown error',
      'surah': 'Surah',
      'ayah': 'Ayah',
      'juz': 'Juz',
      'hizb': 'Hizb',
      'page': 'Page',
      'readMore': 'Read More',
      'bookmark': 'Add to Bookmarks',
      'removeBookmark': 'Remove from Bookmarks',
      'share': 'Share',
      'copy': 'Copy',
      'fontSize': 'Font Size',
      'theme': 'Theme',
      'language': 'Language',
      'arabic': 'العربية',
      'english': 'English',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'small': 'Small',
      'medium': 'Medium',
      'large': 'Large',
      'extraLarge': 'Extra Large',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
