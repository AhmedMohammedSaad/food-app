import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Orders', style: AppTextStyle.font18SemiBoldCharcoal),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.orderTracking);
          },
          child: Container(
            padding: EdgeInsets.all(16.r),
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
            child: Row(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.slate200,
                    image: const DecorationImage(
                      image: NetworkImage(
                        ' https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'McDonald\'s',
                        style: AppTextStyle.font16SemiBoldCharcoal,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '3 items • \$24.99',
                        style: AppTextStyle.font14RegularSlate600,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'On the Way',
                              style: AppTextStyle.font12MediumSlate300.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.slate400),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
