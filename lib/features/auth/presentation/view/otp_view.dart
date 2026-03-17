import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';
import '../../../../core/router/routes.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
                style: IconButton.styleFrom(backgroundColor: AppColors.slate50),
              ),
              SizedBox(height: 24.h),
              Text("Verification Code", style: AppTextStyle.font24SemiBoldCharcoal),
              SizedBox(height: 8.h),
              Text(
                "Please enter the code we sent to your email.",
                style: AppTextStyle.font16MediumSlate500,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        style: AppTextStyle.font24SemiBoldCharcoal,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              AppDefaultButton(
                text: "Verify",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.home);
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(
                      text: "Don't receive any code? ",
                      style: AppTextStyle.font14RegularSlate600,
                      children: [
                        TextSpan(text: "Resend", style: AppTextStyle.font14BoldPrimary),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
