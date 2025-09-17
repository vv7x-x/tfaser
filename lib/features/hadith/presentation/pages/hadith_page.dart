import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/hadith_card.dart';
import '../widgets/hadith_categories.dart';
import '../widgets/hadith_search_bar.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({super.key});

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _hadiths = [
    {
      'id': '1',
      'title': 'حديث الإيمان',
      'arabicText': 'إنما الأعمال بالنيات وإنما لكل امرئ ما نوى',
      'translation': 'إنما الأعمال بالنيات وإنما لكل امرئ ما نوى',
      'source': 'صحيح البخاري',
      'narrator': 'عمر بن الخطاب',
      'grade': 'صحيح',
      'category': 'الإيمان',
    },
    {
      'id': '2',
      'title': 'حديث الحب',
      'arabicText': 'لا يؤمن أحدكم حتى يحب لأخيه ما يحب لنفسه',
      'translation': 'لا يؤمن أحدكم حتى يحب لأخيه ما يحب لنفسه',
      'source': 'صحيح البخاري',
      'narrator': 'أنس بن مالك',
      'grade': 'صحيح',
      'category': 'الأخلاق',
    },
    {
      'id': '3',
      'title': 'حديث الصدقة',
      'arabicText': 'الصدقة تطفئ الخطيئة كما يطفئ الماء النار',
      'translation': 'الصدقة تطفئ الخطيئة كما يطفئ الماء النار',
      'source': 'سنن الترمذي',
      'narrator': 'عبد الله بن مسعود',
      'grade': 'حسن',
      'category': 'العبادات',
    },
    {
      'id': '4',
      'title': 'حديث العلم',
      'arabicText': 'طلب العلم فريضة على كل مسلم',
      'translation': 'طلب العلم فريضة على كل مسلم',
      'source': 'سنن ابن ماجه',
      'narrator': 'أنس بن مالك',
      'grade': 'حسن',
      'category': 'العلم',
    },
    {
      'id': '5',
      'title': 'حديث الصبر',
      'arabicText': 'ما يصيب المسلم من نصب ولا وصب ولا هم ولا حزن ولا أذى ولا غم حتى الشوكة يشاكها إلا كفر الله بها من خطاياه',
      'translation': 'ما يصيب المسلم من نصب ولا وصب ولا هم ولا حزن ولا أذى ولا غم حتى الشوكة يشاكها إلا كفر الله بها من خطاياه',
      'source': 'صحيح البخاري',
      'narrator': 'أبو سعيد الخدري',
      'grade': 'صحيح',
      'category': 'الصبر',
    },
  ];

  final List<Map<String, String>> _categories = [
    {'id': 'all', 'name': 'جميع الأحاديث', 'icon': 'all'},
    {'id': 'الإيمان', 'name': 'الإيمان', 'icon': 'faith'},
    {'id': 'الأخلاق', 'name': 'الأخلاق', 'icon': 'ethics'},
    {'id': 'العبادات', 'name': 'العبادات', 'icon': 'worship'},
    {'id': 'العلم', 'name': 'العلم', 'icon': 'knowledge'},
    {'id': 'الصبر', 'name': 'الصبر', 'icon': 'patience'},
  ];

  List<Map<String, dynamic>> get _filteredHadiths {
    List<Map<String, dynamic>> filtered = _hadiths;

    // Filter by category
    if (_selectedCategory != 'all') {
      filtered = filtered.where((hadith) => 
        hadith['category'] == _selectedCategory).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((hadith) =>
        hadith['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        hadith['arabicText'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        hadith['translation'].toString().toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tafsir), // Using tafsir as hadith
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Categories
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                HadithSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                HadithCategories(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onCategoryChanged: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Hadiths List
          Expanded(
            child: _filteredHadiths.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد أحاديث',
                          style: AppTextStyles.headline6.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredHadiths.length,
                    itemBuilder: (context, index) {
                      final hadith = _filteredHadiths[index];
                      return HadithCard(
                        hadith: hadith,
                        onTap: () => _showHadithDetails(hadith),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).search),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'ابحث في الأحاديث...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
              });
              Navigator.pop(context);
            },
            child: const Text('مسح'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصفية الأحاديث'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _categories.map((category) {
            return RadioListTile<String>(
              title: Text(category['name']!),
              value: category['id']!,
              groupValue: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showHadithDetails(Map<String, dynamic> hadith) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Title
              Text(
                hadith['title'],
                style: AppTextStyles.headline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Arabic Text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  hadith['arabicText'],
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              
              // Translation
              Text(
                'الترجمة:',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                hadith['translation'],
                style: AppTextStyles.bodyLarge.copyWith(
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              
              // Details
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'المصدر',
                      hadith['source'],
                      Icons.book,
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      'الراوي',
                      hadith['narrator'],
                      Icons.person,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'الدرجة',
                      hadith['grade'],
                      Icons.star,
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      'التصنيف',
                      hadith['category'],
                      Icons.category,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Add to bookmarks
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم إضافة الحديث للمحفوظات'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add),
                      label: const Text('إضافة للمحفوظات'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Share hadith
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم نسخ الحديث'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('مشاركة'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
