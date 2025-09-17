import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/surah_list_tile.dart';
import '../widgets/quran_search_bar.dart';
import '../widgets/quran_filters.dart';
import '../bloc/quran_bloc.dart';
import '../../../../shared/services/quran_api_service.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranBloc(),
      child: const _QuranPageContent(),
    );
  }
}

class _QuranPageContent extends StatefulWidget {
  const _QuranPageContent();

  @override
  State<_QuranPageContent> createState() => _QuranPageContentState();
}

class _QuranPageContentState extends State<_QuranPageContent> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<QuranBloc>().add(LoadSurahs());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quran),
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
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                QuranSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                    context.read<QuranBloc>().add(SearchSurahs(value));
                  },
                ),
                const SizedBox(height: 12),
                QuranFilters(
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                    context.read<QuranBloc>().add(FilterSurahs(filter));
                  },
                ),
              ],
            ),
          ),
          
          // Surahs List
          Expanded(
            child: BlocBuilder<QuranBloc, QuranState>(
              builder: (context, state) {
                if (state is QuranLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is QuranLoaded) {
                  final surahs = state.filteredSurahs;
                  if (surahs.isEmpty) {
                    return Center(
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
                            'لا توجد سور',
                            style: AppTextStyles.headline6.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: surahs.length,
                    itemBuilder: (context, index) {
                      final surah = surahs[index];
                      return SurahListTile(
                        surah: surah,
                        onTap: () => _navigateToSurah(surah),
                      );
                    },
                  );
                } else if (state is QuranError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<QuranBloc>().add(LoadSurahs());
                          },
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }
                
                return const SizedBox.shrink();
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
            hintText: 'ابحث في السور...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            context.read<QuranBloc>().add(SearchSurahs(value));
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
              });
              context.read<QuranBloc>().add(SearchSurahs(''));
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
        title: const Text('تصفية السور'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('جميع السور'),
              value: 'all',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                context.read<QuranBloc>().add(FilterSurahs(value));
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('مكية'),
              value: 'makkah',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                context.read<QuranBloc>().add(FilterSurahs(value));
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('مدنية'),
              value: 'madinah',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                context.read<QuranBloc>().add(FilterSurahs(value));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSurah(surah) {
    // TODO: Navigate to surah details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('فتح سورة ${surah.name}'),
      ),
    );
  }
}