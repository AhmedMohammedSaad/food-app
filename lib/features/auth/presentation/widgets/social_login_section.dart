import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.slate200)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Or Login with",
                style: AppTextStyle.font14RegularSlate600,
              ),
            ),
            Expanded(child: Divider(color: AppColors.slate200)),
          ],
        ),
        SizedBox(height: 24.h),
        // Social login buttons would go here in the future
        Center(
          child: TextButton(
            onPressed: () => Navigator.pushNamed(context, Routes.register),
            child: Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: AppTextStyle.font14RegularSlate600,
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: AppTextStyle.font14BoldPrimary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
