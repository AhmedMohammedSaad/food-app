import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import 'onboarding_page_item.dart';

class OnboardingBodySection extends StatefulWidget {
  const OnboardingBodySection({super.key});

  @override
  State<OnboardingBodySection> createState() => _OnboardingBodySectionState();
}

class _OnboardingBodySectionState extends State<OnboardingBodySection> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingComplete) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else if (state is OnboardingPageChanged) {
          _pageController.animateToPage(
            state.index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, Routes.login),
                    child: Text(
                      "Skip",
                      style: AppTextStyle.font14BoldPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cubit.pages.length,
                    onPageChanged: cubit.onPageChanged,
                    itemBuilder: (context, index) {
                      return OnboardingPageItem(model: cubit.pages[index]);
                    },
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cubit.pages.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: cubit.currentIndex == index ? 24.w : 10.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: cubit.currentIndex == index ? AppColors.primary : AppColors.slate200,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                AppDefaultButton(
                  text: cubit.currentIndex == cubit.pages.length - 1 ? "Get Started" : "Next",
                  onPressed: cubit.next,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
