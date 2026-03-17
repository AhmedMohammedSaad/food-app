import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.h),
        Text("Login", style: AppTextStyle.font24SemiBoldCharcoal),
        SizedBox(height: 8.h),
        Text(
          "Welcome back! Glad to see you again.",
          style: AppTextStyle.font16MediumSlate500,
        ),
      ],
    );
  }
}
