import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TasbihSelector extends StatelessWidget {
  final List<Map<String, String>> tasbihList;
  final String selectedTasbih;
  final ValueChanged<Map<String, String>> onTasbihChanged;

  const TasbihSelector({
    super.key,
    required this.tasbihList,
    required this.selectedTasbih,
    required this.onTasbihChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر التسبيحة',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tasbihList.length,
              itemBuilder: (context, index) {
                final tasbih = tasbihList[index];
                final isSelected = tasbih['arabic'] == selectedTasbih;
                
                return GestureDetector(
                  onTap: () => onTasbihChanged(tasbih),
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.greyLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tasbih['arabic']!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected ? AppColors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tasbih['transliteration']!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isSelected 
                                ? AppColors.white.withOpacity(0.8)
                                : AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.white.withOpacity(0.2)
                                : AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${tasbih['count']} مرة',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isSelected ? AppColors.white : AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
