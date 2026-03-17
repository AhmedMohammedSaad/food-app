import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../../data/models/home_models.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.restaurantDetails,
          arguments: restaurant,
        );
      },
      child: Container(
        width: 260.w,
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.slate100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Image.network(
                    restaurant.imageUrl,
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
                if (restaurant.hasFreeDelivery)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "Free Delivery",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 12.sp),
                        SizedBox(width: 2.w),
                        Text(
                          restaurant.rating.toString(),
                          style: AppTextStyle.font12BoldCharcoal,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: AppTextStyle.font14BoldCharcoal),
                  SizedBox(height: 4.h),
                  Text(
                    "${restaurant.tags.join(' • ')} • \$\$",
                    style: AppTextStyle.font12MediumSlate300,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: AppColors.slate400,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        restaurant.deliveryTime,
                        style: AppTextStyle.font12MediumSlate300.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.slate400,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        restaurant.distance,
                        style: AppTextStyle.font12MediumSlate300.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
