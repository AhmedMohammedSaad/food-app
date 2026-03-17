import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/onboarding_page_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingPageModel model;

  const OnboardingPageItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Image.network(
            model.imagePath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.error, color: Colors.red, size: 50),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          model.title,
          style: AppTextStyle.font24SemiBoldCharcoal,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          model.description,
          style: AppTextStyle.font16MediumSlate500,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
