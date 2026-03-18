import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import 'cart_item_widget.dart';

class CartListSection extends StatelessWidget {
  const CartListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.success) {
          if (state.cartItems.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: const Text('Your cart is empty'),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.cartItems.length,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              final item = state.cartItems[index];
              return CartItemWidget(
                item: item,
                onIncrement: () =>
                    context.read<CartCubit>().updateQuantity(item.id, 1),
                onDecrement: () =>
                    context.read<CartCubit>().updateQuantity(item.id, -1),
                onRemove: () =>
                    context.read<CartCubit>().removeItem(item.id),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
