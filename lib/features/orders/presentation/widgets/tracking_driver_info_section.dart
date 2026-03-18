import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class TrackingDriverInfoSection extends StatelessWidget {
  const TrackingDriverInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.slate200,
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1599566150163-29194dcaad36',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cameron Williamson',
                  style: AppTextStyle.font16SemiBoldCharcoal,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Delivery Partner',
                  style: AppTextStyle.font14RegularSlate600,
                ),
              ],
            ),
          ),
          _buildActionButton(Icons.chat_bubble_outline, AppColors.primary),
          SizedBox(width: 12.w),
          _buildActionButton(Icons.phone_outlined, AppColors.success),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20.r),
    );
  }
}
