import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

// Timer state
final cravingTimerProvider =
    StateNotifierProvider.autoDispose<CravingTimerNotifier, int>((ref) {
  return CravingTimerNotifier();
});

class CravingTimerNotifier extends StateNotifier<int> {
  Timer? _timer;

  CravingTimerNotifier() : super(300) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Breathing State
final breathingStateProvider =
    StateProvider.autoDispose<String>((ref) => 'Tap to Start');

// Saving Log Provider
final cravingLogProvider = Provider.autoDispose((ref) {
  final userRepo = ref.watch(userRepositoryProvider);
  return CravingLogger(userRepo);
});

class CravingLogger {
  final UserRepository _repository;
  CravingLogger(this._repository);

  Future<void> logCraving({
    required double intensity,
    required String outcome, // 'survived', 'relapsed'
  }) async {
    // We would use a subcollection 'craving_logs' here
    final user = _repository.currentUser;
    if (user != null) {
      // Mock log for MVP
      // In Real implementation:
      // await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('craving_logs').add(...)
      print('Logged Craving: Intensity $intensity, Outcome: $outcome');

      if (outcome == 'relapsed') {
        // Handle relapse logic updating user profile
        // reset streak, etc. UC-012
        final userModelStream = await _repository.getUserData().first;
        if (userModelStream != null) {
          final updated = userModelStream.copyWith(
            quitDate: DateTime.now(),
            progressSummary: userModelStream.progressSummary?.copyWith(
              relapseCount:
                  (userModelStream.progressSummary?.relapseCount ?? 0) + 1,
            ),
          );
          await _repository.saveUserData(updated);
        }
      }
    }
  }
}
