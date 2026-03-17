import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/home_models.dart';
import 'restaurant_item.dart';

class HomePopularRestaurantsSection extends StatelessWidget {
  final List<RestaurantModel> restaurants;
  final VoidCallback onViewAll;

  const HomePopularRestaurantsSection({
    super.key,
    required this.restaurants,
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
              Text("Popular Restaurants", style: AppTextStyle.font18SemiBoldCharcoal),
              GestureDetector(
                onTap: onViewAll,
                child: Text("View all", style: AppTextStyle.font14BoldPrimary),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: restaurants.map((restaurant) => RestaurantItem(restaurant: restaurant)).toList(),
          ),
        ),
      ],
    );
  }

}
