import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CompassWidget extends StatefulWidget {
  final double heading;
  final double qiblaAngle;
  final bool isCalibrating;
  final ValueChanged<double> onHeadingChanged;

  const CompassWidget({
    super.key,
    required this.heading,
    required this.qiblaAngle,
    required this.isCalibrating,
    required this.onHeadingChanged,
  });

  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(CompassWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.heading != oldWidget.heading) {
      _rotationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Simulate heading change for demo
        final newHeading = (widget.heading + 45) % 360;
        widget.onHeadingChanged(newHeading);
      },
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          final currentHeading = widget.heading + (_rotationAnimation.value * 45);
          final qiblaDirection = (widget.qiblaAngle - currentHeading) % 360;
          
          return Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
              border: Border.all(
                color: AppColors.primary,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Compass Background
                CustomPaint(
                  painter: CompassPainter(
                    heading: currentHeading,
                    qiblaDirection: qiblaDirection,
                    isCalibrating: widget.isCalibrating,
                  ),
                  size: const Size(300, 300),
                ),
                
                // Center Point
                Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                      border: Border.all(
                        color: AppColors.white,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                
                // Calibration Indicator
                if (widget.isCalibrating)
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'جاري المعايرة...',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CompassPainter extends CustomPainter {
  final double heading;
  final double qiblaDirection;
  final bool isCalibrating;

  CompassPainter({
    required this.heading,
    required this.qiblaDirection,
    required this.isCalibrating,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw compass background
    final backgroundPaint = Paint()
      ..color = AppColors.background
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius - 2, backgroundPaint);

    // Draw direction markers
    _drawDirectionMarkers(canvas, center, radius);

    // Draw qibla arrow
    _drawQiblaArrow(canvas, center, radius);

    // Draw compass needle
    _drawCompassNeedle(canvas, center, radius);
  }

  void _drawDirectionMarkers(Canvas canvas, Offset center, double radius) {
    final markerPaint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.rtl,
    );

    const directions = ['ش', 'غ', 'ج', 'ش'];
    const angles = [0, 90, 180, 270];

    for (int i = 0; i < directions.length; i++) {
      final angle = angles[i] * math.pi / 180;
      final x = center.dx + (radius - 30) * math.cos(angle);
      final y = center.dy + (radius - 30) * math.sin(angle);

      // Draw marker line
      final markerStart = Offset(
        center.dx + (radius - 20) * math.cos(angle),
        center.dy + (radius - 20) * math.sin(angle),
      );
      final markerEnd = Offset(
        center.dx + (radius - 10) * math.cos(angle),
        center.dy + (radius - 10) * math.sin(angle),
      );

      canvas.drawLine(markerStart, markerEnd, markerPaint);

      // Draw direction text
      textPainter.text = TextSpan(
        text: directions[i],
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  void _drawQiblaArrow(Canvas canvas, Offset center, double radius) {
    final qiblaAngle = qiblaDirection * math.pi / 180;
    final arrowPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    final arrowLength = radius - 40;
    final arrowWidth = 8.0;

    final arrowTip = Offset(
      center.dx + arrowLength * math.cos(qiblaAngle),
      center.dy + arrowLength * math.sin(qiblaAngle),
    );

    final arrowLeft = Offset(
      center.dx + (arrowLength - 20) * math.cos(qiblaAngle - 0.3),
      center.dy + (arrowLength - 20) * math.sin(qiblaAngle - 0.3),
    );

    final arrowRight = Offset(
      center.dx + (arrowLength - 20) * math.cos(qiblaAngle + 0.3),
      center.dy + (arrowLength - 20) * math.sin(qiblaAngle + 0.3),
    );

    arrowPath.moveTo(arrowTip.dx, arrowTip.dy);
    arrowPath.lineTo(arrowLeft.dx, arrowLeft.dy);
    arrowPath.lineTo(arrowRight.dx, arrowRight.dy);
    arrowPath.close();

    canvas.drawPath(arrowPath, arrowPaint);

    // Draw "قبلة" text
    final textPainter = TextPainter(
      textDirection: TextDirection.rtl,
    );
    textPainter.text = TextSpan(
      text: 'قبلة',
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        arrowTip.dx - textPainter.width / 2,
        arrowTip.dy - 30,
      ),
    );
  }

  void _drawCompassNeedle(Canvas canvas, Offset center, double radius) {
    final needlePaint = Paint()
      ..color = AppColors.error
      ..style = PaintingStyle.fill;

    final needleLength = radius - 60;
    final needleAngle = heading * math.pi / 180;

    final needleTip = Offset(
      center.dx + needleLength * math.cos(needleAngle),
      center.dy + needleLength * math.sin(needleAngle),
    );

    final needleBase = Offset(
      center.dx - needleLength * 0.3 * math.cos(needleAngle),
      center.dy - needleLength * 0.3 * math.sin(needleAngle),
    );

    final needlePath = Path();
    needlePath.moveTo(needleTip.dx, needleTip.dy);
    needlePath.lineTo(
      needleBase.dx + 5 * math.cos(needleAngle + math.pi / 2),
      needleBase.dy + 5 * math.sin(needleAngle + math.pi / 2),
    );
    needlePath.lineTo(
      needleBase.dx + 5 * math.cos(needleAngle - math.pi / 2),
      needleBase.dy + 5 * math.sin(needleAngle - math.pi / 2),
    );
    needlePath.close();

    canvas.drawPath(needlePath, needlePaint);
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) {
    return heading != oldDelegate.heading ||
           qiblaDirection != oldDelegate.qiblaDirection ||
           isCalibrating != oldDelegate.isCalibrating;
  }
}
