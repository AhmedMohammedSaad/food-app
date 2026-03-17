import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';
import '../../../home/presentation/widgets/food_item.dart';
import '../../../home/presentation/widgets/restaurant_item.dart';

class SearchResultsSection extends StatelessWidget {
  final List<RestaurantModel> restaurants;
  final List<FoodModel> foods;

  const SearchResultsSection({
    super.key,
    required this.restaurants,
    required this.foods,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (restaurants.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              child: Text(
                'Restaurants',
                style: AppTextStyle.font18SemiBoldCharcoal,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (context, index) => RestaurantItem(
                restaurant: restaurants[index],
              ),
            ),
          ],
          if (foods.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Text(
                'Foods',
                style: AppTextStyle.font18SemiBoldCharcoal,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foods.length,
              itemBuilder: (context, index) => FoodItem(food: foods[index]),
            ),
          ],
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
