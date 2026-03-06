import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Colors from CSS Template ---
const _primaryColor = Color(0xFF38FF14);
const _bgColor = Color(0xFF12230F);
const _surfaceColor = Color(0xFF1E293B); // Slate-800
const _textMutedColor = Color(0xFF94A3B8); // Slate-400
const _textDarkerColor = Color(0xFF64748B); // Slate-500

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    final currentStep = ref.read(onboardingStepProvider);
    if (currentStep < 4) {
      ref.read(onboardingStepProvider.notifier).state = currentStep + 1;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _previousPage() {
    final currentStep = ref.read(onboardingStepProvider);
    if (currentStep > 0) {
      ref.read(onboardingStepProvider.notifier).state = currentStep - 1;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    await ref.read(onboardingViewModelProvider.notifier).completeOnboarding();
    if (mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(onboardingStepProvider);
    const totalSteps = 5;

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _bgColor,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: _primaryColor,
          surface: _bgColor,
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header & Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.smoke_free, color: _primaryColor, size: 32),
                        const SizedBox(width: 8),
                        Text(
                          'ZEROPUFF',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _primaryColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        'Step ${currentStep + 1} of $totalSteps',
                        style: const TextStyle(
                          color: _primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress Bar
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _surfaceColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (currentStep + 1) / totalSteps,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Page Content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _NameStep(onNext: _nextPage, onBack: null),
                      _HabitsStep(onNext: _nextPage, onBack: _previousPage),
                      _ReasonsStep(onNext: _nextPage, onBack: _previousPage),
                      _TargetStep(onNext: _nextPage, onBack: _previousPage),
                      _DateStep(onNext: _nextPage, onBack: _previousPage),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Shared Footer ---
class _Footer extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final String nextLabel;

  const _Footer({this.onBack, this.onNext, this.nextLabel = 'Continue'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (onBack != null) ...[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: onBack,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: _surfaceColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onNext,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: onNext != null ? _primaryColor : _surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: onNext != null
                        ? [
                            BoxShadow(
                              color: _primaryColor.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nextLabel,
                        style: TextStyle(
                          color: onNext != null ? _bgColor : _textMutedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      if (onNext != null) ...[
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: _bgColor, size: 20),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'By continuing, you agree to our Terms and Privacy Policy.',
          style: TextStyle(color: _textDarkerColor, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// --- Step 1: Name ---
class _NameStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;
  const _NameStep({required this.onNext, this.onBack});

  @override
  ConsumerState<_NameStep> createState() => _NameStepState();
}

class _NameStepState extends ConsumerState<_NameStep> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'What is your name?',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Let\'s personalize your ZeroPuff journey.',
          style: TextStyle(color: _textMutedColor, fontSize: 16),
        ),
        const SizedBox(height: 48),
        TextField(
          controller: _controller,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: const TextStyle(color: _textDarkerColor),
            filled: true,
            fillColor: _surfaceColor.withOpacity(0.3),
            contentPadding: const EdgeInsets.all(24),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: _primaryColor, width: 2),
            ),
          ),
          onChanged: (val) {
            ref.read(onboardingViewModelProvider.notifier).updateName(val);
            setState(() {});
          },
        ),
        const Spacer(),
        _Footer(
          onBack: widget.onBack,
          onNext: _controller.text.trim().isNotEmpty ? widget.onNext : null,
        ),
      ],
    );
  }
}

// --- Step 2: Habits ---
class _HabitsStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;
  const _HabitsStep({required this.onNext, this.onBack});

  @override
  ConsumerState<_HabitsStep> createState() => _HabitsStepState();
}

class _HabitsStepState extends ConsumerState<_HabitsStep> {
  double _cigsPerDay = 20;
  double _pricePerPack = 30000;
  double _cigsPerPack = 20;

  Widget _buildCustomSlider({
    required String title,
    required String valueLabel,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _surfaceColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _surfaceColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            valueLabel,
            style: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: _primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: _textMutedColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: _primaryColor,
              inactiveTrackColor: _surfaceColor,
              thumbColor: _primaryColor,
              overlayColor: _primaryColor.withOpacity(0.2),
              trackHeight: 8,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your habits?',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'We use this to calculate your potential savings.',
          style: TextStyle(color: _textMutedColor, fontSize: 16),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: ListView(
            children: [
              _buildCustomSlider(
                title: 'Cigarettes per day',
                valueLabel: _cigsPerDay.toInt().toString(),
                value: _cigsPerDay,
                min: 1,
                max: 60,
                onChanged: (v) => setState(() => _cigsPerDay = v),
              ),
              const SizedBox(height: 16),
              _buildCustomSlider(
                title: 'Price per pack (Rp)',
                valueLabel: 'Rp ${_pricePerPack.toInt()}',
                value: _pricePerPack,
                min: 10000,
                max: 100000,
                onChanged: (v) => setState(() => _pricePerPack = v),
              ),
              const SizedBox(height: 16),
              _buildCustomSlider(
                title: 'Cigarettes per pack',
                valueLabel: _cigsPerPack.toInt().toString(),
                value: _cigsPerPack,
                min: 10,
                max: 20,
                onChanged: (v) => setState(() => _cigsPerPack = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Footer(
          onBack: widget.onBack,
          onNext: () {
            ref.read(onboardingViewModelProvider.notifier).updateSmokingHabits(
                  cigsPerDay: _cigsPerDay.toInt(),
                  pricePerPack: _pricePerPack,
                  cigsPerPack: _cigsPerPack.toInt(),
                );
            widget.onNext();
          },
        ),
      ],
    );
  }
}

// --- Step 3: Reasons ---
class _ReasonsStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;
  const _ReasonsStep({required this.onNext, this.onBack});

  @override
  ConsumerState<_ReasonsStep> createState() => _ReasonsStepState();
}

class _ReasonsStepState extends ConsumerState<_ReasonsStep> {
  final List<Map<String, dynamic>> _options = [
    {'name': 'Health', 'icon': Icons.favorite},
    {'name': 'Money', 'icon': Icons.savings},
    {'name': 'Family', 'icon': Icons.family_restroom},
    {'name': 'Appearance', 'icon': Icons.face},
    {'name': 'Fitness', 'icon': Icons.fitness_center},
  ];
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Why quit?',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Select your main motivations.',
          style: TextStyle(color: _textMutedColor, fontSize: 16),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: _options.length,
            itemBuilder: (context, index) {
              final option = _options[index];
              final isSelected = _selected.contains(option['name']);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selected.remove(option['name']);
                    } else {
                      _selected.add(option['name']);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? _primaryColor.withOpacity(0.1) : _surfaceColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? _primaryColor : _surfaceColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        option['icon'],
                        size: 40,
                        color: isSelected ? _primaryColor : _textDarkerColor,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        option['name'],
                        style: TextStyle(
                          color: isSelected ? _primaryColor : Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _Footer(
          onBack: widget.onBack,
          onNext: _selected.isNotEmpty
              ? () {
                  ref.read(onboardingViewModelProvider.notifier).updateQuitReasons(_selected.toList());
                  widget.onNext();
                }
              : null,
        ),
      ],
    );
  }
}

// --- Step 4: Target ---
class _TargetStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;
  const _TargetStep({required this.onNext, this.onBack});

  @override
  ConsumerState<_TargetStep> createState() => _TargetStepState();
}

class _TargetStepState extends ConsumerState<_TargetStep> {
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();

  Widget _buildTextField(TextEditingController controller, String hint, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _textDarkerColor),
        filled: true,
        fillColor: _surfaceColor.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
      ),
      onChanged: (v) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Savings Target',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'What do you want to buy with the money you save?',
          style: TextStyle(color: _textMutedColor, fontSize: 16),
        ),
        const SizedBox(height: 48),
        _buildTextField(_itemController, 'Item Name (e.g. PS5)'),
        const SizedBox(height: 16),
        _buildTextField(_priceController, 'Target Price (Rp)', isNumber: true),
        const Spacer(),
        _Footer(
          onBack: widget.onBack,
          onNext: (_itemController.text.isNotEmpty && _priceController.text.isNotEmpty)
              ? () {
                  ref.read(onboardingViewModelProvider.notifier).updateSavingsTarget(
                        _itemController.text,
                        double.tryParse(_priceController.text) ?? 0,
                      );
                  widget.onNext();
                }
              : null,
        ),
      ],
    );
  }
}

// --- Step 5: Quit Date ---
class _DateStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;
  const _DateStep({required this.onNext, this.onBack});

  @override
  ConsumerState<_DateStep> createState() => _DateStepState();
}

class _DateStepState extends ConsumerState<_DateStep> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Set Quit Date',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'When does your journey begin?',
          style: TextStyle(color: _textMutedColor, fontSize: 16),
        ),
        const SizedBox(height: 48),
        
        GestureDetector(
          onTap: () {
            setState(() => _selectedDate = DateTime.now());
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _selectedDate != null && _selectedDate!.day == DateTime.now().day
                  ? _primaryColor.withOpacity(0.1)
                  : _surfaceColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _selectedDate != null && _selectedDate!.day == DateTime.now().day
                    ? _primaryColor
                    : _surfaceColor.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.flash_on,
                  size: 32,
                  color: _selectedDate != null && _selectedDate!.day == DateTime.now().day
                      ? _primaryColor
                      : _textMutedColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start TODAY',
                        style: TextStyle(
                          color: _selectedDate != null && _selectedDate!.day == DateTime.now().day
                              ? _primaryColor
                              : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Right now, cold turkey.',
                        style: TextStyle(color: _textDarkerColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 1)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: _primaryColor,
                      onPrimary: _bgColor,
                      surface: _bgColor,
                      onSurface: Colors.white,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() => _selectedDate = date);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _selectedDate != null && _selectedDate!.day != DateTime.now().day
                  ? _primaryColor.withOpacity(0.1)
                  : _surfaceColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _selectedDate != null && _selectedDate!.day != DateTime.now().day
                    ? _primaryColor
                    : _surfaceColor.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 32,
                  color: _selectedDate != null && _selectedDate!.day != DateTime.now().day
                      ? _primaryColor
                      : _textMutedColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedDate != null && _selectedDate!.day != DateTime.now().day
                            ? 'Scheduled: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : 'Schedule later',
                        style: TextStyle(
                          color: _selectedDate != null && _selectedDate!.day != DateTime.now().day
                              ? _primaryColor
                              : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Pick a future date to quit.',
                        style: TextStyle(color: _textDarkerColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        _Footer(
          onBack: widget.onBack,
          nextLabel: 'Finish & Start',
          onNext: _selectedDate != null
              ? () {
                  ref.read(onboardingViewModelProvider.notifier).updateQuitDate(_selectedDate!);
                  widget.onNext();
                }
              : null,
        ),
      ],
    );
  }
}
