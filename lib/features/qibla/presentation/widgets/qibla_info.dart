import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class QiblaInfo extends StatelessWidget {
  final double qiblaDirection;
  final bool isCalibrating;

  const QiblaInfo({
    super.key,
    required this.qiblaDirection,
    required this.isCalibrating,
  });

  @override
  Widget build(BuildContext context) {
    final directionText = _getDirectionText(qiblaDirection);
    final accuracy = _getAccuracy(qiblaDirection);

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Direction Arrow
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: Center(
              child: Transform.rotate(
                angle: qiblaDirection * math.pi / 180,
                child: Icon(
                  Icons.navigation,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Direction Text
          Text(
            directionText,
            style: AppTextStyles.headline5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 8),
          
          // Angle Text
          Text(
            '${qiblaDirection.toStringAsFixed(1)}°',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Accuracy Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getAccuracyIcon(accuracy),
                size: 16,
                color: _getAccuracyColor(accuracy),
              ),
              const SizedBox(width: 8),
              Text(
                accuracy,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: _getAccuracyColor(accuracy),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          if (isCalibrating) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.warning,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.warning),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'جاري المعايرة...',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getDirectionText(double direction) {
    if (direction >= 337.5 || direction < 22.5) {
      return 'شمال';
    } else if (direction >= 22.5 && direction < 67.5) {
      return 'شمال شرق';
    } else if (direction >= 67.5 && direction < 112.5) {
      return 'شرق';
    } else if (direction >= 112.5 && direction < 157.5) {
      return 'جنوب شرق';
    } else if (direction >= 157.5 && direction < 202.5) {
      return 'جنوب';
    } else if (direction >= 202.5 && direction < 247.5) {
      return 'جنوب غرب';
    } else if (direction >= 247.5 && direction < 292.5) {
      return 'غرب';
    } else {
      return 'شمال غرب';
    }
  }

  String _getAccuracy(double direction) {
    final accuracy = (90 - direction.abs()).abs();
    if (accuracy <= 5) {
      return 'دقة عالية';
    } else if (accuracy <= 15) {
      return 'دقة متوسطة';
    } else {
      return 'دقة منخفضة';
    }
  }

  IconData _getAccuracyIcon(String accuracy) {
    switch (accuracy) {
      case 'دقة عالية':
        return Icons.check_circle;
      case 'دقة متوسطة':
        return Icons.info;
      default:
        return Icons.warning;
    }
  }

  Color _getAccuracyColor(String accuracy) {
    switch (accuracy) {
      case 'دقة عالية':
        return AppColors.success;
      case 'دقة متوسطة':
        return AppColors.warning;
      default:
        return AppColors.error;
    }
  }
}
