import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/home_models.dart';
import 'food_item.dart';

class HomeRecommendedSection extends StatelessWidget {
  final List<FoodModel> foods;
  final VoidCallback onViewAll;

  const HomeRecommendedSection({
    super.key,
    required this.foods,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recommended For You", style: AppTextStyle.font18SemiBoldCharcoal),
              GestureDetector(
                onTap: onViewAll,
                child: Text("View all", style: AppTextStyle.font14BoldPrimary),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: foods.length,
          itemBuilder: (context, index) => FoodItem(food: foods[index]),
        ),
      ],
    );
  }

}
