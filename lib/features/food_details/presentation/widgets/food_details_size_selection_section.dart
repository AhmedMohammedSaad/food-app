import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/data/models/home_models.dart';
import '../cubit/food_details_cubit.dart';
import '../cubit/food_details_state.dart';

class FoodDetailsSizeSelectionSection extends StatelessWidget {
  final List<SizeModel> sizes;

  const FoodDetailsSizeSelectionSection({super.key, required this.sizes});

  @override
  Widget build(BuildContext context) {
    if (sizes.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customize Size', style: AppTextStyle.font18SemiBoldCharcoal),
        SizedBox(height: 12.h),
        BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
          builder: (context, state) {
            return Row(
              children: sizes.map((size) {
                final isSelected = state.selectedSize == size;
                return Expanded(
                  child: SizeOptionWidget(
                    size: size,
                    isSelected: isSelected,
                    isLast: size == sizes.last,
                    onTap: () =>
                        context.read<FoodDetailsCubit>().selectSize(size),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class SizeOptionWidget extends StatelessWidget {
  final SizeModel size;
  final bool isSelected;
  final bool isLast;
  final VoidCallback onTap;

  const SizeOptionWidget({
    super.key,
    required this.size,
    required this.isSelected,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: isLast ? 0 : 12.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.slate200,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            size.name,
            style: isSelected
                ? AppTextStyle.font14BoldPrimary
                : AppTextStyle.font14SemiBoldCharcoal.copyWith(
                    color: Colors.grey[600],
                  ),
          ),
        ),
      ),
    );
  }
}
