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

  DateTime streakStartDate = user!.quitDate!;
  if (user.progressSummary?.lastSlipDate != null && 
      user.progressSummary!.lastSlipDate!.isAfter(streakStartDate)) {
    streakStartDate = user.progressSummary!.lastSlipDate!;
  }

  final diff = DateTime.now().difference(streakStartDate);
  return diff.inDays < 0 ? 0 : diff.inDays;
});

// Helper provider for money saved
final moneySavedProvider = Provider.autoDispose<double>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.quitDate == null || user?.smokingProfile == null) return 0.0;

  final diff = DateTime.now().difference(user!.quitDate!);
  final daysFree = (diff.inDays < 0 ? 0 : diff.inDays) + 1;

  final profile = user.smokingProfile!;
  if (profile.cigarettesPerPack == 0) return 0.0;

  final costPerCigarette = profile.pricePerPack / profile.cigarettesPerPack;
  final costPerDay = costPerCigarette * profile.cigarettesPerDay;
  final totalSlips = user.progressSummary?.totalSlips ?? 0;

  return (costPerDay * daysFree) - (costPerCigarette * totalSlips);
});

// Helper provider for cigarettes avoided
final cigarettesAvoidedProvider = Provider.autoDispose<int>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.quitDate == null || user?.smokingProfile == null) return 0;

  final diff = DateTime.now().difference(user!.quitDate!);
  final daysFree = (diff.inDays < 0 ? 0 : diff.inDays) + 1;
  final totalSlips = user.progressSummary?.totalSlips ?? 0;

  return (user.smokingProfile!.cigarettesPerDay * daysFree).toInt() - totalSlips;
});

// Helper provider for today's slips
final todaysSlipsProvider = Provider.autoDispose<int>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.progressSummary == null) return 0;
  
  final progress = user!.progressSummary!;
  if (progress.lastSlipDate != null) {
    final now = DateTime.now();
    if (progress.lastSlipDate!.day != now.day || 
        progress.lastSlipDate!.month != now.month || 
        progress.lastSlipDate!.year != now.year) {
      return 0; // Reset conceptually, but db will update on next save
    }
  }
  return progress.todaySlips;
});

// Actions
final dashboardActionsProvider = Provider.autoDispose((ref) {
  return DashboardActions(ref.watch(userRepositoryProvider), ref.watch(userStreamProvider).value);
});

class DashboardActions {
  final UserRepository repo;
  final UserModel? user;

  DashboardActions(this.repo, this.user);

  Future<void> logSlips(int count) async {
    if (user == null || count <= 0) return;
    final now = DateTime.now();
    var progress = user!.progressSummary ?? const ProgressSummary();
    
    int newTodaySlips = progress.todaySlips + count;
    if (progress.lastSlipDate != null) {
      if (progress.lastSlipDate!.day != now.day || 
          progress.lastSlipDate!.month != now.month || 
          progress.lastSlipDate!.year != now.year) {
        newTodaySlips = count;
      }
    }

    final newProgress = progress.copyWith(
      totalSlips: progress.totalSlips + count,
      todaySlips: newTodaySlips,
      lastSlipDate: now,
    );

    final updatedUser = user!.copyWith(progressSummary: newProgress);
    await repo.saveUserData(updatedUser);
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
}
