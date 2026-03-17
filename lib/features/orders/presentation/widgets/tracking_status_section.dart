import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class TrackingStatusSection extends StatelessWidget {
  const TrackingStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: AppTextStyle.font18SemiBoldCharcoal,
          ),
          SizedBox(height: 20.h),
          _buildStep(
            title: 'Order Received',
            time: '10:00 AM',
            isCompleted: true,
            isLast: false,
          ),
          _buildStep(
            title: 'Preparing Food',
            time: '10:15 AM',
            isCompleted: true,
            isLast: false,
          ),
          _buildStep(
            title: 'On the Way',
            time: '10:30 AM',
            isCompleted: false,
            isActive: true,
            isLast: false,
          ),
          _buildStep(
            title: 'Delivered',
            time: 'Est. 10:45 AM',
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String title,
    required String time,
    required bool isCompleted,
    bool isActive = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isActive ? AppColors.primary : AppColors.slate200,
                border: isActive ? Border.all(color: AppColors.primary.withOpacity(0.3), width: 4) : null,
              ),
              child: isCompleted
                  ? Icon(Icons.check, size: 12.r, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 30.h,
                color: isCompleted ? AppColors.primary : AppColors.slate200,
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isActive || isCompleted
                      ? AppTextStyle.font16SemiBoldCharcoal
                      : AppTextStyle.font16RegularCharcoal.copyWith(color: AppColors.slate400),
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: AppTextStyle.font12MediumSlate300,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
