import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/profile_model.dart';

class ProfileHeaderSection extends StatelessWidget {
  final ProfileModel profile;
  final ProfileStatsModel stats;

  const ProfileHeaderSection({
    super.key,
    required this.profile,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.slate100,
          backgroundImage: NetworkImage(
            profile.avatarUrl ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          profile.fullName,
          style: AppTextStyle.font20BoldSlate900,
        ),
        SizedBox(height: 4.h),
        Text(
          profile.email,
          style: AppTextStyle.font14RegularSlate500,
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem("Orders", stats.ordersCount.toString()),
            Container(
              width: 1.w,
              height: 40.h,
              color: AppColors.slate200,
            ),
            _buildStatItem("Reviews", stats.reviewsCount.toString()),
            Container(
              width: 1.w,
              height: 40.h,
              color: AppColors.slate200,
            ),
            _buildStatItem("Favorites", stats.favoritesCount.toString()),
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
