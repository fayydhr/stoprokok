import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

// Provides the current index for the onboarding stepper (0-4)
final onboardingStepProvider = StateProvider<int>((ref) => 0);

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, UserModel>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return OnboardingViewModel(repository);
});

class OnboardingViewModel extends StateNotifier<UserModel> {
  final UserRepository _repository;

  OnboardingViewModel(this._repository)
      : super(UserModel(
          id: '',
          name: '',
          email: '',
          createdAt: DateTime.now(),
          smokingProfile: const SmokingProfile(),
          savingsTarget: const SavingsTarget(),
          progressSummary: const ProgressSummary(),
        ));

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateSmokingHabits({
    String brand = '',
    String variant = '',
    double pricePerPack = 0,
    int cigsPerPack = 0,
    int cigsPerDay = 0,
    int years = 0,
  }) {
    state = state.copyWith(
      smokingProfile: state.smokingProfile?.copyWith(
        brand: brand,
        variant: variant,
        pricePerPack: pricePerPack,
        cigarettesPerPack: cigsPerPack,
        cigarettesPerDay: cigsPerDay,
        yearsSmoking: years,
      ),
    );
  }

  void updateQuitReasons(List<String> reasons, {String? customReason}) {
    state = state.copyWith(
      quitReasons: reasons,
      customQuitReason: customReason,
    );
  }

  void updateSavingsTarget(String itemName, double targetPrice) {
    state = state.copyWith(
      savingsTarget: state.savingsTarget?.copyWith(
        itemName: itemName,
        targetPrice: targetPrice,
      ),
    );
  }

  void updateQuitDate(DateTime date) {
    state = state.copyWith(quitDate: date);
  }

  Future<void> completeOnboarding() async {
    await _repository.saveUserData(state);
  }
}
