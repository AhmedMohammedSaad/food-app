import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/data/models/home_models.dart';
import '../../../home/presentation/widgets/restaurant_item.dart';

class FavoriteRestaurantsSection extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const FavoriteRestaurantsSection({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return const Center(child: Text("No favorite restaurants yet"));
    }

    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: restaurants.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return RestaurantItem(restaurant: restaurants[index]);
      },
    );
  }
}
