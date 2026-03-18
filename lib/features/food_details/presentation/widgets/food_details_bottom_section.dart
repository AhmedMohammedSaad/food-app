import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/food_details_cubit.dart';
import '../cubit/food_details_state.dart';

class FoodDetailsBottomSection extends StatelessWidget {
  const FoodDetailsBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.slate100)),
        ),
        child: Row(
          children: [
            const QuantitySelectorWidget(),
            SizedBox(width: 16.w),
            const AddToCartButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class QuantitySelectorWidget extends StatelessWidget {
  const QuantitySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
        builder: (context, state) {
          return Row(
            children: [
              IconButton(
                onPressed: () =>
                    context.read<FoodDetailsCubit>().updateQuantity(-1),
                icon: Icon(
                  Icons.remove,
                  size: 20.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                width: 30.w,
                child: Text(
                  state.quantity.toString(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font18BoldCharcoal,
                ),
              ),
              IconButton(
                onPressed: () =>
                    context.read<FoodDetailsCubit>().updateQuantity(1),
                icon: Icon(
                  Icons.add,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddToCartButtonWidget extends StatelessWidget {
  const AddToCartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<FoodDetailsCubit, FoodDetailsState>(
        listener: (context, state) {
          if (state.isAddedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to cart!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.isAddingToCart
                ? null
                : () => context.read<FoodDetailsCubit>().addToCart(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 4,
              shadowColor: AppColors.primary.withValues(alpha: 0.3),
            ),
            child: state.isAddingToCart
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Add to Cart - \$${state.totalPrice.toStringAsFixed(2)}',
                    style: AppTextStyle.font16BoldCharcoal.copyWith(
                      color: Colors.white,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
