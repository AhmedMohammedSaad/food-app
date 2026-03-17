import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileOptionsSection extends StatelessWidget {
  const ProfileOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Account"),
        _buildOptionItem(
          icon: Icons.person_outline,
          title: "Personal Information",
          onTap: () {},
        ),
        _buildOptionItem(
          icon: Icons.location_on_outlined,
          title: "Delivery Addresses",
          onTap: () {},
        ),
        _buildOptionItem(
          icon: Icons.payment_outlined,
          title: "Payment Methods",
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        _buildSectionHeader("Preferences"),
        _buildOptionItem(
          icon: Icons.notifications_none_outlined,
          title: "Notifications",
          onTap: () {},
        ),
        _buildOptionItem(
          icon: Icons.settings_outlined,
          title: "Settings",
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        _buildSectionHeader("Other"),
        _buildOptionItem(
          icon: Icons.help_outline,
          title: "Help & Support",
          onTap: () {},
        ),
        _buildOptionItem(
          icon: Icons.info_outline,
          title: "About Us",
          onTap: () {},
        ),
        SizedBox(height: 24.h),
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.red),
            label: Text(
              "Log Out",
              style: AppTextStyle.font16BoldSlate900.copyWith(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: AppTextStyle.font16BoldSlate900,
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.slate50,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24.r),
      ),
      title: Text(
        title,
        style: AppTextStyle.font14MediumSlate900,
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.r, color: AppColors.slate300),
      onTap: onTap,
    );
  }
}
