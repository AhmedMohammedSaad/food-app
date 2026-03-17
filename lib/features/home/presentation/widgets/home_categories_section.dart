import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/home_models.dart';

class HomeCategoriesSection extends StatelessWidget {
  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final Function(String?) onCategorySelected;

  const HomeCategoriesSection({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text("Categories", style: AppTextStyle.font18SemiBoldCharcoal),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: categories
                .map((category) => _buildCategoryItem(category))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    final isSelected = selectedCategoryId == category.id;
    return GestureDetector(
      onTap: () => onCategorySelected(category.id),
      child: Container(
        margin: EdgeInsets.only(right: 16.w),
        child: Column(
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.slate100,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Center(
                child: Text(category.icon, style: TextStyle(fontSize: 32.sp)),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              category.name,
              style: AppTextStyle.font12MediumSlate300.copyWith(
                color: isSelected ? AppColors.primary : AppColors.slate600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
