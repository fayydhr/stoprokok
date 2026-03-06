import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/onboarding/views/onboarding_screen.dart';
import '../../features/dashboard/views/dashboard_screen.dart';
import '../../features/craving_kit/views/craving_kit_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/craving',
        builder: (context, state) => const CravingKitScreen(),
      ),
    ],
  );
});
