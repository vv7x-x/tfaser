import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/compass_widget.dart';
import '../widgets/location_info.dart';
import '../widgets/qibla_info.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage>
    with TickerProviderStateMixin {
  late AnimationController _compassController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  double _currentHeading = 0.0;
  double _qiblaAngle = 0.0;
  bool _isCalibrating = false;
  String _currentLocation = 'جدة، المملكة العربية السعودية';
  double _distanceToQibla = 0.0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeLocation();
  }

  void _setupAnimations() {
    _compassController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _compassController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _initializeLocation() {
    // TODO: Get actual location using GPS
    _qiblaAngle = 45.0; // Mock angle for Jeddah
    _distanceToQibla = 1200.0; // Mock distance in km
  }

  void _calibrateCompass() {
    setState(() {
      _isCalibrating = true;
    });

    // Simulate calibration process
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isCalibrating = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم معايرة البوصلة بنجاح'),
          backgroundColor: AppColors.success,
        ),
      );
    });
  }

  void _updateHeading(double heading) {
    setState(() {
      _currentHeading = heading;
    });
  }

  double _getQiblaDirection() {
    return (_qiblaAngle - _currentHeading) % 360;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('اتجاه القبلة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _calibrateCompass,
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _showLocationDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Info
          LocationInfo(
            location: _currentLocation,
            distance: _distanceToQibla,
          ),
          
          // Compass
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Compass Widget
                  CompassWidget(
                    heading: _currentHeading,
                    qiblaAngle: _qiblaAngle,
                    isCalibrating: _isCalibrating,
                    onHeadingChanged: _updateHeading,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Qibla Info
                  QiblaInfo(
                    qiblaDirection: _getQiblaDirection(),
                    isCalibrating: _isCalibrating,
                  ),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isCalibrating ? null : _calibrateCompass,
                  icon: _isCalibrating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          ),
                        )
                      : const Icon(Icons.refresh),
                  label: Text(_isCalibrating ? 'جاري المعايرة...' : 'معايرة البوصلة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showLocationDialog,
                  icon: const Icon(Icons.location_on),
                  label: const Text('تغيير الموقع'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تغيير الموقع'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'اسم المدينة',
                hintText: 'أدخل اسم المدينة',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _currentLocation = value.isNotEmpty ? value : _currentLocation;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'خط العرض',
                hintText: '21.4858',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'خط الطول',
                hintText: '39.1925',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Update location and recalculate qibla angle
            },
            child: const Text('تحديث'),
          ),
        ],
      ),
    );
  }
}
