import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';

class FoodDetailsIngredientsSection extends StatelessWidget {
  final List<IngredientModel> ingredients;

  const FoodDetailsIngredientsSection({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ingredients', style: AppTextStyle.font18SemiBoldCharcoal),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];
              return IngredientItemWidget(ingredient: ingredient);
            },
          ),
        ),
      ],
    );
  }
}

class IngredientItemWidget extends StatelessWidget {
  final IngredientModel ingredient;

  const IngredientItemWidget({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Column(
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIngredientIcon(ingredient.icon),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            ingredient.name,
            style: AppTextStyle.font12RegularCharcoal.copyWith(
              color: Colors.grey[600],
              fontSize: 10.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIngredientIcon(String name) {
    switch (name.toLowerCase()) {
      case 'cheese':
      case 'chess':
        return Icons.layers;
      case 'tomato':
      case 'nutrition':
        return Icons.restaurant;
      case 'basil':
      case 'eco':
      case 'arugula':
        return Icons.eco;
      case 'olive oil':
      case 'oil_barrel':
        return Icons.opacity;
      case 'mushroom':
        return Icons.restaurant_menu;
      case 'meat':
      case 'beef':
      case 'steak':
      case 'pepperoni':
        return Icons.kebab_dining;
      case 'grain':
      case 'flour':
      case 'dough':
      case 'bread':
      case 'pasta':
        return Icons.bakery_dining;
      default:
        return Icons.circle;
    }
  }
}
