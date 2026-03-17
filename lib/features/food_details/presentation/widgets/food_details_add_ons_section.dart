import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';
import '../cubit/food_details_cubit.dart';
import '../cubit/food_details_state.dart';

class FoodDetailsAddOnsSection extends StatelessWidget {
  final List<AddOnModel> addOns;

  const FoodDetailsAddOnsSection({super.key, required this.addOns});

  @override
  Widget build(BuildContext context) {
    if (addOns.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add-ons', style: AppTextStyle.font18SemiBoldCharcoal),
        SizedBox(height: 12.h),
        BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
          builder: (context, state) {
            return Column(
              children: addOns.map((addOn) {
                final isSelected = state.selectedAddOns.contains(addOn);
                return AddOnItemWidget(
                  addOn: addOn,
                  isSelected: isSelected,
                  onTap: () =>
                      context.read<FoodDetailsCubit>().toggleAddOn(addOn),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class AddOnItemWidget extends StatelessWidget {
  final AddOnModel addOn;
  final bool isSelected;
  final VoidCallback onTap;

  const AddOnItemWidget({
    super.key,
    required this.addOn,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.slate300,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14.sp,
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Text(
              addOn.name,
              style: AppTextStyle.font14SemiBoldCharcoal,
            ),
            const Spacer(),
            Text(
              '+\$${addOn.price.toStringAsFixed(2)}',
              style: AppTextStyle.font14BoldPrimary.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
