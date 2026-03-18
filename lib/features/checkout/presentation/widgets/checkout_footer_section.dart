import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../orders/presentation/cubit/order_cubit.dart';
import '../../../orders/presentation/cubit/order_state.dart';

class CheckoutFooterSection extends StatelessWidget {
  const CheckoutFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, orderState) {
        final isLoading = orderState is OrderPlaceLoading;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      final cartCubit = context.read<CartCubit>();
                      final cartState = cartCubit.state;
                      
                      if (cartState.cartItems.isEmpty) return;

                      // Assuming all items from same restaurant for this design
                      final restaurantId = cartState.cartItems.first.food.restaurantId;

                      context.read<OrderCubit>().placeOrder(
                            restaurantId: restaurantId,
                            addressId: null, // Hardcoded for now
                            subtotal: cartState.subtotal,
                            deliveryFee: cartState.deliveryFee,
                            tax: cartState.tax,
                            totalAmount: cartState.total,
                            paymentMethod: 'Credit Card', // Hardcoded for now
                            cartItems: cartState.cartItems,
                          );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(double.infinity, 56.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Place Order',
                      style: AppTextStyle.font18SemiBoldWhite,
                    ),
            ),
          ),
        );
      },
    );
  }
}
