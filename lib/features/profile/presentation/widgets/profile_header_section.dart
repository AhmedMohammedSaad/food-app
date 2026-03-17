import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.slate100,
          backgroundImage: const NetworkImage(
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Oswald Al-Wanes",
          style: AppTextStyle.font20BoldSlate900,
        ),
        SizedBox(height: 4.h),
        Text(
          "oswald@example.com",
          style: AppTextStyle.font14RegularSlate500,
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem("Orders", "24"),
            Container(
              width: 1.w,
              height: 40.h,
              color: AppColors.slate200,
            ),
            _buildStatItem("Reviews", "12"),
            Container(
              width: 1.w,
              height: 40.h,
              color: AppColors.slate200,
            ),
            _buildStatItem("Favorites", "45"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyle.font18BoldPrimary,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyle.font12MediumSlate300,
        ),
      ],
    );
  }
}
