import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

// StreamProvider that listens to real-time user data from Firestore
final userStreamProvider = StreamProvider.autoDispose<UserModel?>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserData();
});

// Helper provider for current streak days exclusively
final currentStreakDaysProvider = Provider.autoDispose<int>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.quitDate == null) return 0;

  final quitDate = user!.quitDate!;
  final now = DateTime.now();
  final todayUtc = DateTime.utc(now.year, now.month, now.day);
  final quitDayUtc = DateTime.utc(quitDate.year, quitDate.month, quitDate.day);
  
  final slipHistory = user.progressSummary?.slipHistory ?? {};

  // 1. Find the most recent slip date from the user's entire history
  DateTime? latestSlipUtc;
  final sortedKeys = slipHistory.keys.toList()..sort();
  for (final key in sortedKeys.reversed) {
    if ((slipHistory[key] as num?)?.toInt() != 0) {
      final parts = key.split('-');
      if (parts.length == 3) {
        latestSlipUtc = DateTime.utc(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }
      break;
    }
  }

  // 2. Determine base starting point (quit date)
  int daysSinceQuit = todayUtc.difference(quitDayUtc).inDays;
  if (daysSinceQuit < 0) daysSinceQuit = 0;

  // 3. If there's a slip, calculate days since the most recent slip
  if (latestSlipUtc != null) {
    int daysSinceSlip = todayUtc.difference(latestSlipUtc).inDays;
    // Streak cannot be negative. If slip is today, it's 0.
    if (daysSinceSlip < 0) daysSinceSlip = 0;
    
    // Streak cannot be larger than the days since quit date, 
    // unless they slipped before they even quit (which shouldn't happen, but just in case, cap it).
    return daysSinceSlip > daysSinceQuit ? daysSinceQuit : daysSinceSlip;
  }

  // 4. No slips found? Then the streak is the entire duration since quit date!
  return daysSinceQuit;
});

Map<String, dynamic> getActiveProfileForDate(SmokingProfile profile, DateTime date) {
  final targetKey = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  
  if (profile.profileHistory.isEmpty) {
    return {
      'pricePerPack': profile.pricePerPack,
      'cigarettesPerPack': profile.cigarettesPerPack,
      'cigarettesPerDay': profile.cigarettesPerDay,
    };
  }

  String? bestKey;
  for (final key in profile.profileHistory.keys.toList()..sort()) {
    if (key.compareTo(targetKey) <= 0) {
      bestKey = key;
    }
  }

  if (bestKey != null) {
    return profile.profileHistory[bestKey] as Map<String, dynamic>;
  } else {
    final firstKey = profile.profileHistory.keys.toList()..sort();
    if (firstKey.isNotEmpty) {
       return profile.profileHistory[firstKey.first] as Map<String, dynamic>;
    }
    return {
      'pricePerPack': profile.pricePerPack,
      'cigarettesPerPack': profile.cigarettesPerPack,
      'cigarettesPerDay': profile.cigarettesPerDay,
    };
  }
}

class DailySavingsRecord {
  final DateTime date;
  final int dayNumber;
  final double expectedSaving;
  final int slips;
  final double penalty;
  final double netSaved;
  final double cumulativeTotal;

  DailySavingsRecord({
    required this.date,
    required this.dayNumber,
    required this.expectedSaving,
    required this.slips,
    required this.penalty,
    required this.netSaved,
    required this.cumulativeTotal,
  });
}

// Unified daily savings history provider
final dailySavingsHistoryProvider = Provider.autoDispose<List<DailySavingsRecord>>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.quitDate == null || user?.smokingProfile == null) return [];

  final profile = user!.smokingProfile!;
  final quitDate = user.quitDate!;
  final now = DateTime.now();
  
  // Normalize dates to UTC midnight to avoid timezone/daylight saving issues
  final todayUtc = DateTime.utc(now.year, now.month, now.day);
  final quitDayUtc = DateTime.utc(quitDate.year, quitDate.month, quitDate.day);
  
  int totalDaysSinceQuit = todayUtc.difference(quitDayUtc).inDays;
  if (totalDaysSinceQuit < 0) totalDaysSinceQuit = 0;
  
  final slipHistory = user.progressSummary?.slipHistory ?? {};

  double cumulative = 0.0;
  final List<DailySavingsRecord> history = [];

  for (int i = 0; i <= totalDaysSinceQuit; i++) {
    final dUtc = quitDayUtc.add(Duration(days: i));
    final dateKey = "${dUtc.year}-${dUtc.month.toString().padLeft(2, '0')}-${dUtc.day.toString().padLeft(2, '0')}";
    
    // We pass dUtc.toLocal() to active profile getter since it uses local year/month/day
    final dLocal = DateTime(dUtc.year, dUtc.month, dUtc.day);
    final activeProfileMap = getActiveProfileForDate(profile, dLocal);
    
    final double activePricePerPack = (activeProfileMap['pricePerPack'] as num?)?.toDouble() ?? 0.0;
    final int activeCigarettesPerPack = (activeProfileMap['cigarettesPerPack'] as num?)?.toInt() ?? 1;
    final int activeCigarettesPerDay = (activeProfileMap['cigarettesPerDay'] as num?)?.toInt() ?? 0;
    
    double costPerDay = 0.0;
    double penalty = 0.0;
    int slipsThatDay = (slipHistory[dateKey] as num?)?.toInt() ?? 0;

    if (activeCigarettesPerPack > 0) {
      final costPerCigarette = activePricePerPack / activeCigarettesPerPack;
      costPerDay = costPerCigarette * activeCigarettesPerDay;
      penalty = slipsThatDay * costPerCigarette;
    }

    final netSaved = costPerDay - penalty;
    
    cumulative += netSaved;
    if (cumulative < 0) cumulative = 0;

    history.add(DailySavingsRecord(
      date: dLocal,
      dayNumber: i + 1,
      expectedSaving: costPerDay,
      slips: slipsThatDay,
      penalty: penalty,
      netSaved: netSaved,
      cumulativeTotal: cumulative,
    ));
  }

  return history;
});

// Helper provider for money saved
final moneySavedProvider = Provider.autoDispose<double>((ref) {
  final history = ref.watch(dailySavingsHistoryProvider);
  if (history.isEmpty) return 0.0;
  return history.last.cumulativeTotal;
});

// Helper provider for cigarettes avoided
final cigarettesAvoidedProvider = Provider.autoDispose<int>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.quitDate == null || user?.smokingProfile == null) return 0;

  final profile = user!.smokingProfile!;
  final quitDate = user.quitDate!;
  final now = DateTime.now();
  final totalDaysSinceQuit = now.difference(quitDate).inDays;
  int cumulativeAvoided = 0;

  for (int i = 0; i <= totalDaysSinceQuit; i++) {
    final d = quitDate.add(Duration(days: i));
    final activeProfileMap = getActiveProfileForDate(profile, d);
    final int activeCigarettesPerDay = (activeProfileMap['cigarettesPerDay'] as num?)?.toInt() ?? 0;
    cumulativeAvoided += activeCigarettesPerDay;
  }

  final totalSlips = user.progressSummary?.totalSlips ?? 0;
  return cumulativeAvoided - totalSlips;
});

// Helper provider for today's slips
final todaysSlipsProvider = Provider.autoDispose<int>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.progressSummary == null) return 0;
  
  final now = DateTime.now();
  final dateKey = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  return (user!.progressSummary!.slipHistory[dateKey] as num?)?.toInt() ?? 0;
});

// Actions
final dashboardActionsProvider = Provider.autoDispose((ref) {
  return DashboardActions(ref.watch(userRepositoryProvider), ref.watch(userStreamProvider).value);
});

class DashboardActions {
  final UserRepository repo;
  final UserModel? user;

  DashboardActions(this.repo, this.user);

  Future<void> logSlips(int count, {DateTime? date}) async {
    if (user == null || count <= 0) return;
    final now = DateTime.now();
    final targetDate = date ?? now;

    final dateKey = "${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}";
    var progress = user!.progressSummary ?? const ProgressSummary();
    
    final newSlipHistory = Map<String, dynamic>.from(progress.slipHistory);
    final currentCount = (newSlipHistory[dateKey] as num?)?.toInt() ?? 0;
    
    int newCount = currentCount + count;
    if (newCount < 0) newCount = 0;
    newSlipHistory[dateKey] = newCount;

    int newTotalSlips = 0;
    newSlipHistory.forEach((key, value) {
      newTotalSlips += (value as num).toInt();
    });

    final todayKey = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    int newTodaySlips = (newSlipHistory[todayKey] as num?)?.toInt() ?? 0;

    DateTime? newLastSlipDate;
    final sortedKeys = newSlipHistory.keys.toList()..sort();
    for (final key in sortedKeys.reversed) {
      if ((newSlipHistory[key] as num?)?.toInt() != 0) {
        final parts = key.split('-');
        if (parts.length == 3) {
          final y = int.parse(parts[0]);
          final m = int.parse(parts[1]);
          final d = int.parse(parts[2]);
          newLastSlipDate = DateTime(y, m, d, now.hour, now.minute, now.second);
        }
        break;
      }
    }

    final newProgress = progress.copyWith(
      totalSlips: newTotalSlips,
      todaySlips: newTodaySlips,
      slipHistory: newSlipHistory,
      lastSlipDate: newLastSlipDate ?? progress.lastSlipDate,
    );

    final updatedUser = user!.copyWith(progressSummary: newProgress);
    await repo.saveUserData(updatedUser);
  }

  Future<bool> updateSmokingProfile(double pricePerPack, int cigarettesPerPack, int cigarettesPerDay) async {
    if (user == null || user!.smokingProfile == null) return false;

    final currentProfile = user!.smokingProfile!;
    final bool isDecreasingTarget = cigarettesPerDay < currentProfile.cigarettesPerDay;
    
    var history = Map<String, dynamic>.from(currentProfile.profileHistory);
    final now = DateTime.now();
    final todayKey = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    if (history.isEmpty && user!.quitDate != null) {
      // Establish baseline at quit date
      final q = user!.quitDate!;
      final quitKey = "${q.year}-${q.month.toString().padLeft(2, '0')}-${q.day.toString().padLeft(2, '0')}";
      if (quitKey != todayKey) {
        history[quitKey] = {
          'pricePerPack': currentProfile.pricePerPack,
          'cigarettesPerPack': currentProfile.cigarettesPerPack,
          'cigarettesPerDay': currentProfile.cigarettesPerDay,
        };
      }
    }

    history[todayKey] = {
      'pricePerPack': pricePerPack,
      'cigarettesPerPack': cigarettesPerPack,
      'cigarettesPerDay': cigarettesPerDay,
    };

    final updatedProfile = currentProfile.copyWith(
      pricePerPack: pricePerPack,
      cigarettesPerPack: cigarettesPerPack,
      cigarettesPerDay: cigarettesPerDay,
      profileHistory: history,
    );

    final updatedUser = user!.copyWith(smokingProfile: updatedProfile);
    await repo.saveUserData(updatedUser);
    
    return isDecreasingTarget;
  }

  Future<void> updateSavingsTarget(String itemName, double targetPrice) async {
    if (user == null) return;
    
    final newTargets = List<SavingsTarget>.from(user!.savingsTargets);
    
    // Migrate legacy target if the user had one prior to the list feature
    if (newTargets.isEmpty && user!.savingsTarget != null && user!.savingsTarget!.itemName.isNotEmpty && user!.savingsTarget!.targetPrice > 0) {
      newTargets.add(user!.savingsTarget!);
    }

    // Append the newly created target
    newTargets.add(
      SavingsTarget(
        itemName: itemName,
        targetPrice: targetPrice,
      ),
    );

    final updatedUser = user!.copyWith(
      savingsTargets: newTargets,
      savingsTarget: const SavingsTarget(), // Clear legacy target to prevent duplicates
    );
    await repo.saveUserData(updatedUser);
  }

  Future<void> editSavingsTarget(int index, String newName, double newPrice) async {
    if (user == null) return;
    
    final newTargets = List<SavingsTarget>.from(user!.savingsTargets);
    if (index >= 0 && index < newTargets.length) {
      newTargets[index] = SavingsTarget(
        itemName: newName,
        targetPrice: newPrice,
      );

      final updatedUser = user!.copyWith(savingsTargets: newTargets);
      await repo.saveUserData(updatedUser);
    }
  }

  Future<void> removeSavingsTarget(int index) async {
    if (user == null) return;
    
    final newTargets = List<SavingsTarget>.from(user!.savingsTargets);
    if (index >= 0 && index < newTargets.length) {
      newTargets.removeAt(index);

      final updatedUser = user!.copyWith(savingsTargets: newTargets);
      await repo.saveUserData(updatedUser);
    }
  }

  Future<void> debugFastForward() async {
    if (user == null) return;
    
    final newQuitDate = user!.quitDate?.subtract(const Duration(days: 7));
    
    var progress = user!.progressSummary;
    if (progress != null) {
      final newLastSlipDate = progress.lastSlipDate?.subtract(const Duration(days: 7));
      
      final newSlipHistory = <String, dynamic>{};
      progress.slipHistory.forEach((key, value) {
        final parts = key.split('-');
        if (parts.length == 3) {
          final d = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
          final shifted = d.subtract(const Duration(days: 7));
          final shiftedKey = "${shifted.year}-${shifted.month.toString().padLeft(2, '0')}-${shifted.day.toString().padLeft(2, '0')}";
          newSlipHistory[shiftedKey] = value;
        }
      });
      progress = progress.copyWith(
        lastSlipDate: newLastSlipDate,
        slipHistory: newSlipHistory,
      );
    }
    
    var profile = user!.smokingProfile;
    if (profile != null) {
      final newProfileHistory = <String, dynamic>{};
      profile.profileHistory.forEach((key, value) {
        final parts = key.split('-');
        if (parts.length == 3) {
          final d = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
          final shifted = d.subtract(const Duration(days: 7));
          final shiftedKey = "${shifted.year}-${shifted.month.toString().padLeft(2, '0')}-${shifted.day.toString().padLeft(2, '0')}";
          newProfileHistory[shiftedKey] = value;
        }
      });
      profile = profile.copyWith(profileHistory: newProfileHistory);
    }
    
    final updatedUser = user!.copyWith(
      quitDate: newQuitDate ?? user!.quitDate,
      progressSummary: progress ?? user!.progressSummary,
      smokingProfile: profile ?? user!.smokingProfile,
    );
    await repo.saveUserData(updatedUser);
  }
}
