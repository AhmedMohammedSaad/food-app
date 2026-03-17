// lib/features/onboarding/presentation/cubit/onboarding_state.dart

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int index;
  OnboardingPageChanged(this.index);
}

class OnboardingComplete extends OnboardingState {}
