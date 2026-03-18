import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartOrderSummarySection extends StatelessWidget {
  const CartOrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.success && state.cartItems.isNotEmpty) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.slate100.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', '\$${state.subtotal.toStringAsFixed(2)}'),
                SizedBox(height: 12.h),
                _buildSummaryRow('Delivery Fee', '\$${state.deliveryFee.toStringAsFixed(2)}'),
                SizedBox(height: 12.h),
                _buildSummaryRow('Tax', '\$${state.tax.toStringAsFixed(2)}'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Divider(color: AppColors.slate400.withOpacity(0.2)),
                ),
                _buildSummaryRow(
                  'Total',
                  '\$${state.total.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyle.font18SemiBoldCharcoal
              : AppTextStyle.font14RegularSlate600,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyle.font14BoldPrimary.copyWith(fontSize: 18.sp)
              : AppTextStyle.font14MediumSlate700,
        ),
      ],
    );
  }
}
