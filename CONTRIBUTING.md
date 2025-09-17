# دليل المساهمة

نرحب بمساهماتكم في تطوير تطبيق تفسير القرآن الكريم! يرجى قراءة هذا الدليل بعناية قبل البدء.

## 🚀 البدء السريع

### 1. إعداد البيئة

```bash
# استنساخ المشروع
git clone https://github.com/your-username/quran-tafsir-app.git
cd quran-tafsir-app

# تثبيت التبعيات
flutter pub get

# تشغيل الاختبارات
flutter test
```

### 2. إنشاء فرع جديد

```bash
# إنشاء فرع للميزة الجديدة
git checkout -b feature/your-feature-name

# أو فرع لإصلاح خطأ
git checkout -b fix/your-bug-fix
```

## 📋 قواعد المساهمة

### 1. تسمية الفروع

- `feature/` - للميزات الجديدة
- `fix/` - لإصلاح الأخطاء
- `docs/` - للتوثيق
- `refactor/` - لإعادة هيكلة الكود
- `test/` - للاختبارات

### 2. تسمية الـ Commits

استخدم الصيغة التالية:

```
type(scope): description

Examples:
feat(home): add search functionality
fix(api): resolve connection timeout issue
docs(readme): update installation guide
refactor(theme): simplify color definitions
test(service): add unit tests for AppService
```

### 3. أنواع الـ Commits

- `feat` - ميزة جديدة
- `fix` - إصلاح خطأ
- `docs` - تغييرات في التوثيق
- `style` - تنسيق الكود
- `refactor` - إعادة هيكلة الكود
- `test` - إضافة أو تعديل الاختبارات
- `chore` - مهام الصيانة

## 🏗️ معايير الكود

### 1. تنسيق الكود

```bash
# تنسيق الكود تلقائياً
dart format .

# تحليل الكود
flutter analyze
```

### 2. هيكلة الملفات

```
lib/
├── core/                    # الملفات الأساسية
│   ├── constants/          # الثوابت
│   ├── theme/              # الثيمات
│   ├── utils/              # الأدوات
│   └── widgets/            # الودجات الأساسية
├── features/               # الميزات
│   └── feature_name/
│       ├── data/           # طبقة البيانات
│       ├── domain/         # طبقة المنطق
│       └── presentation/   # طبقة العرض
├── shared/                 # الملفات المشتركة
│   ├── models/            # النماذج
│   ├── services/          # الخدمات
│   └── widgets/           # الودجات المشتركة
└── l10n/                  # ملفات الترجمة
```

### 3. تسمية الملفات

- استخدم `snake_case` للملفات
- استخدم `PascalCase` للكلاسات
- استخدم `camelCase` للمتغيرات والدوال

### 4. التعليقات

```dart
/// وصف مختصر للدالة
/// 
/// وصف مفصل للدالة ووظيفتها
/// 
/// [param1] وصف المعامل الأول
/// [param2] وصف المعامل الثاني
/// 
/// Returns وصف القيمة المُرجعة
String exampleFunction(String param1, int param2) {
  // تعليق للكود المعقد
  return 'result';
}
```

## 🧪 الاختبارات

### 1. اختبارات الوحدة

```dart
// test/unit/example_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Example Tests', () {
    test('should return correct value', () {
      // Arrange
      const input = 'test';
      
      // Act
      final result = exampleFunction(input);
      
      // Assert
      expect(result, 'expected');
    });
  });
}
```

### 2. اختبارات الودجات

```dart
// test/widget/example_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExampleWidget should display text', (tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: ExampleWidget(text: 'Test'),
      ),
    );

    // Act & Assert
    expect(find.text('Test'), findsOneWidget);
  });
}
```

### 3. اختبارات التكامل

```dart
// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('full app test', (tester) async {
      // Test the full app flow
    });
  });
}
```

## 📝 إرشادات الـ Pull Request

### 1. قبل إنشاء الـ PR

- [ ] تأكد من أن الكود يتبع معايير المشروع
- [ ] أضف اختبارات للميزات الجديدة
- [ ] تأكد من أن جميع الاختبارات تمر
- [ ] حدث التوثيق إذا لزم الأمر
- [ ] تأكد من أن الكود يعمل على جميع المنصات المدعومة

### 2. وصف الـ PR

```markdown
## 📝 الوصف
وصف مختصر للتغييرات

## 🔗 الرابط
رابط للمسألة المرتبطة (إن وجدت)

## 🧪 الاختبارات
- [ ] اختبارات الوحدة
- [ ] اختبارات الودجات
- [ ] اختبارات التكامل

## 📱 المنصات
- [ ] Android
- [ ] iOS
- [ ] Web
- [ ] Desktop

## 📸 لقطات الشاشة
(إذا كانت التغييرات تؤثر على الواجهة)
```

### 3. مراجعة الكود

- راجع الكود بعناية
- تأكد من أن التغييرات منطقية
- تحقق من الأداء والأمان
- اقترح تحسينات إذا لزم الأمر

## 🐛 الإبلاغ عن الأخطاء

### 1. قبل الإبلاغ

- تأكد من أن الخطأ لم يتم الإبلاغ عنه مسبقاً
- جرب أحدث إصدار من التطبيق
- تحقق من التوثيق

### 2. معلومات مطلوبة

```markdown
## 🐛 وصف الخطأ
وصف واضح ومختصر للخطأ

## 🔄 خطوات إعادة الإنتاج
1. اذهب إلى '...'
2. اضغط على '...'
3. مرر لأسفل إلى '...'
4. شاهد الخطأ

## 🎯 النتيجة المتوقعة
ما كنت تتوقع حدوثه

## 📱 البيئة
- الجهاز: [مثال: iPhone 12]
- نظام التشغيل: [مثال: iOS 15.0]
- إصدار التطبيق: [مثال: 1.0.0]

## 📸 لقطات الشاشة
(إذا كانت مفيدة)

## 📋 معلومات إضافية
أي معلومات أخرى مفيدة
```

## 💡 اقتراح الميزات

### 1. قبل الاقتراح

- تأكد من أن الميزة لم يتم اقتراحها مسبقاً
- فكر في الفائدة للمستخدمين
- تأكد من أن الميزة تتماشى مع أهداف المشروع

### 2. معلومات مطلوبة

```markdown
## 💡 الميزة المقترحة
وصف واضح للميزة

## 🎯 المشكلة
ما المشكلة التي تحلها هذه الميزة؟

## 💭 الحل المقترح
كيف تقترح حل هذه المشكلة؟

## 🔄 البدائل
هل فكرت في بدائل أخرى؟

## 📋 معلومات إضافية
أي معلومات أخرى مفيدة
```

## 📞 التواصل

- **GitHub Issues** - للأخطاء والاقتراحات
- **GitHub Discussions** - للمناقشات العامة
- **Email** - your-email@example.com

## 🙏 شكر وتقدير

نشكر جميع المساهمين الذين يساعدون في تطوير هذا المشروع!

---

**ملاحظة**: هذا الدليل قابل للتحديث. يرجى مراجعته بانتظام.
