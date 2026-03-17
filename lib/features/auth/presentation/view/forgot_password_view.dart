import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';
import '../../../../core/presentation/view/widgets/app_default_text_form_field.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

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
              Text("Forgot Password", style: AppTextStyle.font24SemiBoldCharcoal),
              SizedBox(height: 8.h),
              Text(
                "Enter your email address and we will send you a link to reset your password.",
                style: AppTextStyle.font16MediumSlate500,
              ),
              SizedBox(height: 48.h),
              AppDefaultTextFormField(
                controller: emailController,
                label: "Email",
                hintText: "Enter your email",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 32.h),
              AppDefaultButton(
                text: "Send Code",
                onPressed: () {
                  // Navigate to OTP for demo purposes
                  Navigator.pushNamed(context, '/otp');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
