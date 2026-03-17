import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';
import '../../../../core/router/routes.dart';

class MenuItemWidget extends StatelessWidget {
  final FoodModel food;

  const MenuItemWidget({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.foodDetails, arguments: food);
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: AppTextStyle.font16SemiBoldCharcoal,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        food.description,
                        style: AppTextStyle.font12RegularCharcoal.copyWith(
                          color: AppColors.charcoal.withValues(alpha: 0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '\$${food.price.toStringAsFixed(2)}',
                    style: AppTextStyle.font18SemiBoldCharcoal.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Hero(
              tag: 'food_${food.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  food.imageUrl,
                  width: 90.w,
                  height: 90.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
