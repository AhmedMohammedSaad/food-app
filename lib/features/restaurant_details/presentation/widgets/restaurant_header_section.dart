import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';

class RestaurantHeaderSection extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantHeaderSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: AppTextStyle.font24BoldCharcoal,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4.w),
                  Text(
                    restaurant.rating.toString(),
                    style: AppTextStyle.font14SemiBoldCharcoal,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '(324 reviews)',
                    style: AppTextStyle.font14RegularCharcoal.copyWith(
                      color: AppColors.charcoal.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.grey, size: 18),
                  SizedBox(width: 4.w),
                  Text(
                    restaurant.deliveryTime,
                    style: AppTextStyle.font14RegularCharcoal,
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
                  SizedBox(width: 4.w),
                  Text(
                    restaurant.distance,
                    style: AppTextStyle.font14RegularCharcoal,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: restaurant.tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  tag,
                  style: AppTextStyle.font12SemiBoldCharcoal.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
