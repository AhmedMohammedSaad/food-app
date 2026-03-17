import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/data/models/home_models.dart';
import '../cubit/food_details_cubit.dart';
import '../widgets/food_details_add_ons_section.dart';
import '../widgets/food_details_app_bar_section.dart';
import '../widgets/food_details_bottom_section.dart';
import '../widgets/food_details_header_section.dart';
import '../widgets/food_details_ingredients_section.dart';
import '../widgets/food_details_size_selection_section.dart';

class FoodDetailsView extends StatelessWidget {
  final FoodModel food;

  const FoodDetailsView({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodDetailsCubit()..init(food),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                FoodDetailsAppBarSection(food: food),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FoodDetailsHeaderSection(food: food),
                        SizedBox(height: 24.h),
                        FoodDetailsIngredientsSection(
                          ingredients: food.ingredients,
                        ),
                        SizedBox(height: 24.h),
                        FoodDetailsSizeSelectionSection(sizes: food.sizes),
                        SizedBox(height: 24.h),
                        FoodDetailsAddOnsSection(addOns: food.addOns),
                        SizedBox(height: 120.h), // Space for bottom bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const FoodDetailsBottomSection(),
          ],
        ),
      ),
    );
  }
}
