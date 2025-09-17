import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/tasbih_counter.dart';
import '../widgets/tasbih_selector.dart';
import '../widgets/tasbih_history.dart';

class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  int _currentCount = 0;
  int _targetCount = 33;
  String _selectedTasbih = 'سبحان الله';
  bool _isVibrating = true;

  final List<Map<String, String>> _tasbihList = [
    {
      'arabic': 'سبحان الله',
      'translation': 'سبحان الله',
      'transliteration': 'Subhan Allah',
      'count': '33',
    },
    {
      'arabic': 'الحمد لله',
      'translation': 'الحمد لله',
      'transliteration': 'Alhamdulillah',
      'count': '33',
    },
    {
      'arabic': 'الله أكبر',
      'translation': 'الله أكبر',
      'transliteration': 'Allahu Akbar',
      'count': '33',
    },
    {
      'arabic': 'لا إله إلا الله',
      'translation': 'لا إله إلا الله',
      'transliteration': 'La ilaha illa Allah',
      'count': '100',
    },
    {
      'arabic': 'أستغفر الله',
      'translation': 'أستغفر الله',
      'transliteration': 'Astaghfirullah',
      'count': '100',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCount() {
    setState(() {
      _currentCount++;
    });

    // Trigger animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Vibrate if enabled
    if (_isVibrating) {
      HapticFeedback.lightImpact();
    }

    // Check if target reached
    if (_currentCount >= _targetCount) {
      _showCompletionDialog();
    }
  }

  void _resetCount() {
    setState(() {
      _currentCount = 0;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تهانينا!'),
        content: Text(
          'لقد أكملت ${_targetCount} تسبيحة من $_selectedTasbih',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetCount();
            },
            child: const Text('بدء جديد'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bookmarks), // Using bookmarks as tasbih
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showHistory,
          ),
          IconButton(
            icon: Icon(_isVibrating ? Icons.vibration : Icons.vibration_off),
            onPressed: () {
              setState(() {
                _isVibrating = !_isVibrating;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tasbih Selector
          TasbihSelector(
            tasbihList: _tasbihList,
            selectedTasbih: _selectedTasbih,
            onTasbihChanged: (tasbih) {
              setState(() {
                _selectedTasbih = tasbih['arabic']!;
                _targetCount = int.parse(tasbih['count']!);
                _currentCount = 0;
              });
            },
          ),
          
          // Counter Display
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Current Tasbih Text
                  Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _selectedTasbih,
                          style: AppTextStyles.headline3.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getTransliteration(),
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  // Counter Circle
                  GestureDetector(
                    onTap: _incrementCount,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Transform.rotate(
                            angle: _rotationAnimation.value,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primaryDark,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$_currentCount',
                                      style: AppTextStyles.headline1.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'من $_targetCount',
                                      style: AppTextStyles.bodyLarge.copyWith(
                                        color: AppColors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Progress Bar
                  Container(
                    width: 300,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _currentCount / _targetCount,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Progress Text
                  Text(
                    '${((_currentCount / _targetCount) * 100).toInt()}% مكتمل',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
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
                  onPressed: _resetCount,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة تعيين'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _incrementCount,
                  icon: const Icon(Icons.add),
                  label: const Text('تسبيح'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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

  String _getTransliteration() {
    final tasbih = _tasbihList.firstWhere(
      (t) => t['arabic'] == _selectedTasbih,
      orElse: () => _tasbihList.first,
    );
    return tasbih['transliteration']!;
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const TasbihHistory(),
    );
  }
}
