import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_options_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyle.font18BoldSlate900,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeaderSection(),
              SizedBox(height: 32),
              ProfileOptionsSection(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
