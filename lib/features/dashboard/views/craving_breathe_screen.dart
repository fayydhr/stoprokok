import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CravingBreatheScreen extends StatefulWidget {
  const CravingBreatheScreen({super.key});

  @override
  State<CravingBreatheScreen> createState() => _CravingBreatheScreenState();
}

class _CravingBreatheScreenState extends State<CravingBreatheScreen> with TickerProviderStateMixin {
  late AnimationController _breatheController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  Timer? _timer;
  int _secondsRemaining = 60;
  String _breatheInstruction = "Ready when you are...";
  bool _isActive = false;

  @override
  void initState() {
    super.initState();

    // Setup Breathing Animation Loop (4s Inhale, 4s Exhale generally, or 4-7-8 method)
    // For simplicity: 4s scale up (Inhale), 4s scale down (Exhale)
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOutSine),
    );

    _glowAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOutSine),
    );

    _breatheController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _breatheInstruction = "Exhale slowly...");
        _breatheController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _breatheInstruction = "Inhale through your nose...");
        _breatheController.forward();
      }
    });

    // Don't forward controller or start timer here; wait for Start button.
  }

  void _toggleBreathing() {
    if (_isActive) {
      // Stop
      _timer?.cancel();
      _breatheController.stop();
      _breatheController.reset();
      setState(() {
        _isActive = false;
        _breatheInstruction = "Ready when you are...";
        _secondsRemaining = 60;
      });
    } else {
      // Start
      setState(() {
        _isActive = true;
        _breatheInstruction = "Inhale through your nose...";
        _secondsRemaining = 60;
      });
      _breatheController.forward();
      
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          setState(() {
            _secondsRemaining--;
          });
        } else {
          timer.cancel();
          _breatheController.stop();
          _breatheController.reset();
          setState(() {
            _isActive = false;
            _breatheInstruction = "You did great!";
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (60 - _secondsRemaining) / 60.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top Progress Indicator
            Container(
              height: 4,
              width: double.infinity,
              color: AppColors.slate800,
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: MediaQuery.of(context).size.width * progress,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(color: AppColors.primary, blurRadius: 10),
                  ],
                ),
              ),
            ),
            
            // Header
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ZeroPuff',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Titles
                    const Text(
                      'Breathe with me...',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slate100,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This craving will pass.',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.slate400,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Breathing Circle
                    SizedBox(
                      height: 280,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow
                          AnimatedBuilder(
                            animation: _glowAnimation,
                            builder: (context, child) {
                              return Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withOpacity(_glowAnimation.value),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(_glowAnimation.value * 0.5),
                                      blurRadius: 60,
                                      spreadRadius: 20,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          
                          // Expanding Ring
                          AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Main Center Circle
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 4,
                              ),
                              color: AppColors.backgroundDark,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 40,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    const Text(
                                      '00',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                        letterSpacing: -2.0,
                                      ),
                                    ),
                                    Text(
                                      ':',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primary.withOpacity(0.7),
                                      ),
                                    ),
                                    Text(
                                      _secondsRemaining.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                        letterSpacing: -2.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'SECONDS',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: AppColors.primary.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Instruction Banner
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        key: ValueKey<String>(_breatheInstruction),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                        ),
                        child: Text(
                          _breatheInstruction,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                      ),
                      onPressed: _toggleBreathing,
                      icon: Icon(_isActive ? Icons.stop_circle : Icons.play_circle_fill, size: 24),
                      label: Text(
                        _isActive ? 'Stop' : 'Start',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Bottom nav padding reduced
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
