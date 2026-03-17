import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class CheckoutOrderSummarySection extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;

  const CheckoutOrderSummarySection({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.slate100.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Delivery Fee', '\$${deliveryFee.toStringAsFixed(2)}'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Tax', '\$${tax.toStringAsFixed(2)}'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(color: AppColors.slate400.withOpacity(0.2)),
          ),
          _buildSummaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
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
