import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class RegisterHeaderSection extends StatelessWidget {
  const RegisterHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          style: IconButton.styleFrom(backgroundColor: AppColors.slate50),
        ),
        SizedBox(height: 24.h),
        Text("Create Account", style: AppTextStyle.font24SemiBoldCharcoal),
        SizedBox(height: 8.h),
        Text("Sign up to get started", style: AppTextStyle.font16MediumSlate500),
      ],
    );
  }
}
