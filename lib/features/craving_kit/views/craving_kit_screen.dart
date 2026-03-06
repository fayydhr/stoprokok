import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/craving_kit_viewmodel.dart';
import 'dart:async';

class CravingKitScreen extends ConsumerStatefulWidget {
  const CravingKitScreen({super.key});

  @override
  ConsumerState<CravingKitScreen> createState() => _CravingKitScreenState();
}

class _CravingKitScreenState extends ConsumerState<CravingKitScreen> {
  int _currentView = 0; // 0: Main, 1: Breathing, 2: Report
  double _intensity = 5;

  @override
  Widget build(BuildContext context) {
    if (_currentView == 1) return _buildBreathingView();
    if (_currentView == 2) return _buildReportView();
    return _buildMainView();
  }

  Widget _buildMainView() {
    final timerValue = ref.watch(cravingTimerProvider);
    final minutes = (timerValue / 60).floor().toString().padLeft(2, '0');
    final seconds = (timerValue % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C), // Dark calming color
      appBar: AppBar(
        title: const Text('Emergency Kit'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            Text(
              '$minutes:$seconds',
              style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Craving ini hanya akan berlangsung 3-5 menit.\nBertahanlah, kamu bisa!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const Spacer(),

            // Intensity Slider
            const Text('Seberapa kuat craving saat ini (1-10)?',
                style: TextStyle(color: Colors.white)),
            Slider(
              value: _intensity,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: Colors.deepOrange,
              onChanged: (val) => setState(() => _intensity = val),
            ),

            const Spacer(),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
                backgroundColor: const Color(0xFF4A90E2),
              ),
              onPressed: () => setState(() => _currentView = 1),
              icon: const Icon(Icons.air),
              label: const Text('Latihan Pernapasan (4-7-8)'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
                side: const BorderSide(color: Colors.white54),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // TODO: Open Mini Game
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Mini game belum tersedia di MVP')));
              },
              icon: const Icon(Icons.gamepad),
              label: const Text('Main Mini Game'),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => setState(() => _currentView = 2),
              child: const Text('Selesai / Laporkan',
                  style: TextStyle(color: Colors.white54)),
            )
          ],
        ),
      ),
    );
  }

  // --- BREATHING VIEW ---
  Widget _buildBreathingView() {
    return _BreathingWidget(
      onDone: () => setState(() => _currentView = 2),
      onCancel: () => setState(() => _currentView = 0),
    );
  }

  // --- REPORT VIEW ---
  Widget _buildReportView() {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sesi Selesai',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bagaimana hasilnya?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 48),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 64),
                  backgroundColor: Colors.green.shade600,
                ),
                onPressed: () async {
                  await ref
                      .read(cravingLogProvider)
                      .logCraving(intensity: _intensity, outcome: 'survived');
                  if (mounted) context.go('/dashboard');
                },
                icon: const Icon(Icons.celebration),
                label: const Text('Berhasil Bertahan 🎉',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 64),
                  backgroundColor: Colors.red.shade900,
                ),
                onPressed: () async {
                  await ref
                      .read(cravingLogProvider)
                      .logCraving(intensity: _intensity, outcome: 'relapsed');
                  if (mounted) context.go('/dashboard');
                },
                child: const Text('Saya Kembali Merokok',
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreathingWidget extends StatefulWidget {
  final VoidCallback onDone;
  final VoidCallback onCancel;
  const _BreathingWidget({required this.onDone, required this.onCancel});

  @override
  State<_BreathingWidget> createState() => _BreathingWidgetState();
}

class _BreathingWidgetState extends State<_BreathingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  int _step = 0; // 0: initial, 1: Inhale, 2: Hold, 3: Exhale
  String _message = 'Tap untuk Memulai';
  Timer? _phaseTimer;
  int _cycles = 0;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  void _nextPhase() {
    if (!mounted) return;
    HapticFeedback.mediumImpact();

    if (_step == 0 || _step == 3) {
      if (_step == 3) _cycles++;
      if (_cycles >= 3) {
        // limit 3 cycles for now
        widget.onDone();
        return;
      }

      setState(() {
        _step = 1;
        _message = 'Tarik Napas...';
      });
      _animController.animateTo(1.0,
          duration: const Duration(seconds: 4), curve: Curves.easeInOut);
      _phaseTimer = Timer(const Duration(seconds: 4), _nextPhase);
    } else if (_step == 1) {
      setState(() {
        _step = 2;
        _message = 'Tahan...';
      });
      _phaseTimer = Timer(const Duration(seconds: 7), _nextPhase);
    } else if (_step == 2) {
      setState(() {
        _step = 3;
        _message = 'Hembuskan...';
      });
      _animController.animateTo(0.0,
          duration: const Duration(seconds: 8), curve: Curves.easeInOut);
      _phaseTimer = Timer(const Duration(seconds: 8), _nextPhase);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _phaseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: widget.onCancel,
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: _step == 0 ? _nextPhase : null,
                child: AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      final size = 150 + (_animController.value * 150);
                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF4A90E2).withOpacity(
                                0.5 + (_animController.value * 0.3)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4A90E2).withOpacity(0.5),
                                blurRadius: 40 * _animController.value,
                                spreadRadius: 20 * _animController.value,
                              )
                            ]),
                        child: Center(
                          child: Text(
                            _message,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
