import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';
import '../../domain/entities/onboarding_page_model.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final List<OnboardingPageModel> pages = [
    const OnboardingPageModel(
      title: "Premium Delicacies",
      description:
          "Savor the best flavors from top-rated local restaurants delivered right to your doorstep.",
      imagePath:
          "https://images.unsplash.com/photo-1493770348161-369560ae357d?auto=format&fit=crop&q=80&w=1000",
    ),
    const OnboardingPageModel(
      title: "Lightning Fast Delivery",
      description:
          "Experience the thrill of speed with our dedicated courier network, ensuring your food arrives fresh and hot.",
      imagePath:
          "https://images.unsplash.com/photo-1770927423939-bae721171237?auto=format&fit=crop&q=80",
    ),
    const OnboardingPageModel(
      title: "Follow Your Feast",
      description:
          "Stay updated at every step with real-time tracking from the chef's kitchen to your hands.",
      imagePath:
          "https://images.unsplash.com/photo-1617347454431-f49d7ff5c3b1?auto=format&fit=crop&q=80&w=1000",
    ),
  ];

  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(index));
  }

  void next() {
    if (currentIndex < pages.length - 1) {
      currentIndex++;
      emit(OnboardingPageChanged(currentIndex));
    } else {
      emit(OnboardingComplete());
    }
  }
}
