# تطبيق تفسير القرآن الكريم

تطبيق Flutter احترافي لتفسير القرآن الكريم مع دعم اللغات المتعددة وتصميم عصري.

## ✨ المميزات

- 📖 **تفسير القرآن الكريم** - عرض القرآن مع التفسير
- 🌍 **دعم اللغات المتعددة** - العربية والإنجليزية
- 🎨 **تصميم عصري** - واجهة مستخدم جميلة وسهلة الاستخدام
- 🌙 **الوضع الليلي** - دعم الوضع المظلم والفاتح
- 📱 **متجاوب** - يعمل على جميع أحجام الشاشات
- ⚡ **سريع** - أداء محسن وسريع
- 🔍 **بحث متقدم** - البحث في القرآن والتفسير
- 📚 **المحفوظات** - حفظ الآيات المفضلة
- 🎯 **تنقل سهل** - نظام تنقل بديهي

## 🏗️ البنية المعمارية

```
lib/
├── core/                    # الملفات الأساسية
│   ├── constants/          # الثوابت
│   ├── theme/              # الثيمات والألوان
│   ├── utils/              # الأدوات المساعدة
│   └── widgets/            # الودجات الأساسية
├── features/               # الميزات
│   ├── splash/            # شاشة البداية
│   ├── home/              # الصفحة الرئيسية
│   └── ...
├── shared/                 # الملفات المشتركة
│   ├── models/            # النماذج
│   ├── services/          # الخدمات
│   └── widgets/           # الودجات المشتركة
└── l10n/                  # ملفات الترجمة
```

## 🚀 البدء السريع

### المتطلبات

- Flutter SDK (3.7.2 أو أحدث)
- Dart SDK (3.0.0 أو أحدث)
- Android Studio أو VS Code
- Git

### التثبيت

1. **استنساخ المشروع**
   ```bash
   git clone https://github.com/your-username/quran-tafsir-app.git
   cd quran-tafsir-app
   ```

2. **تثبيت التبعيات**
   ```bash
   flutter pub get
   ```

3. **تشغيل التطبيق**
   ```bash
   flutter run
   ```

## 🛠️ التطوير

### تشغيل الاختبارات

```bash
# اختبارات الوحدة
flutter test

# اختبارات التكامل
flutter test integration_test/

# اختبارات الأداء
flutter test --coverage
```

### تحليل الكود

```bash
# تحليل الكود
flutter analyze

# تنسيق الكود
dart format .
```

### بناء التطبيق

```bash
# بناء APK
flutter build apk --release

# بناء App Bundle
flutter build appbundle --release

# بناء iOS
flutter build ios --release
```

## 📱 المنصات المدعومة

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎨 التخصيص

### الألوان

يمكنك تخصيص الألوان من خلال تعديل ملف `lib/core/theme/app_colors.dart`:

```dart
class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color secondary = Color(0xFF8BC34A);
  // ... المزيد من الألوان
}
```

### الخطوط

يمكنك تغيير الخطوط من خلال تعديل ملف `lib/core/theme/app_text_styles.dart`:

```dart
static TextStyle get headline1 => GoogleFonts.cairo(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  // ... المزيد من الخصائص
);
```

## 🌍 الترجمة

### إضافة لغة جديدة

1. أضف ملف `.arb` جديد في `assets/l10n/`
2. أضف الكود في `lib/l10n/app_localizations.dart`
3. أضف اللغة في `supportedLocales`

### مثال

```dart
// assets/l10n/app_fr.arb
{
  "appTitle": "Tafsir du Coran",
  "quran": "Coran"
}
```

## 📦 التبعيات الرئيسية

- **flutter_bloc** - إدارة الحالة
- **go_router** - التنقل
- **dio** - طلبات الشبكة
- **hive** - التخزين المحلي
- **google_fonts** - الخطوط
- **flutter_localizations** - الترجمة

## 🌐 APIs المستخدمة

### القرآن الكريم
- **AlQuran Cloud API** - `https://api.alquran.cloud/v1`
  - تحميل السور والآيات
  - البحث في القرآن
  - الترجمات المختلفة
  - الأجزاء والأحزاب

### الأحاديث
- **Hadith API** - `https://hadithapi.com/api`
  - تحميل الأحاديث
  - البحث في الأحاديث
  - التصنيفات والمصادر
  - الأحاديث العشوائية

### اتجاه القبلة
- **AlAdhan API** - `https://api.aladhan.com/v1`
  - حساب اتجاه القبلة
  - أوقات الصلاة
  - إحداثيات الكعبة

- **BigDataCloud API** - `https://api.bigdatacloud.net`
  - تحديد الموقع الجغرافي
  - العكس الجغرافي (Reverse Geocoding)

## 🤝 المساهمة

نرحب بمساهماتكم! يرجى اتباع الخطوات التالية:

1. Fork المشروع
2. إنشاء فرع للميزة الجديدة (`git checkout -b feature/AmazingFeature`)
3. Commit التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. Push إلى الفرع (`git push origin feature/AmazingFeature`)
5. فتح Pull Request

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - راجع ملف [LICENSE](LICENSE) للتفاصيل.

## 📞 التواصل

- البريد الإلكتروني: your-email@example.com
- GitHub: [@your-username](https://github.com/your-username)
- Twitter: [@your-twitter](https://twitter.com/your-twitter)

## 🙏 شكر وتقدير

- فريق Flutter
- مجتمع المطورين العرب
- جميع المساهمين في المشروع

---

**ملاحظة**: هذا المشروع في مرحلة التطوير النشط. قد تحدث تغييرات كبيرة في المستقبل.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
