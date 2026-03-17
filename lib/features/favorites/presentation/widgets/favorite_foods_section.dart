import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/data/models/home_models.dart';
import '../../../home/presentation/widgets/food_item.dart';

class FavoriteFoodsSection extends StatelessWidget {
  final List<FoodModel> foods;

  const FavoriteFoodsSection({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    if (foods.isEmpty) {
      return const Center(child: Text("No favorite foods yet"));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: foods.length,

        itemBuilder: (context, index) {
          return FoodItem(food: foods[index]);
        },
      ),
    );
  }
}
