import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';

class FoodDetailsHeaderSection extends StatelessWidget {
  final FoodModel food;

  const FoodDetailsHeaderSection({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                food.name,
                style: AppTextStyle.font24BoldCharcoal,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: AppColors.primary, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    food.rating.toString(),
                    style: AppTextStyle.font14BoldPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          food.description,
          style: AppTextStyle.font14RegularCharcoal.copyWith(
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
