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
        if (state is CartSuccess) {
          if (state.items.isEmpty) {
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
            itemCount: state.items.length,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              final item = state.items[index];
              return CartItemWidget(
                item: item,
                onIncrement: () =>
                    context.read<CartCubit>().updateQuantity(item.food.id, 1),
                onDecrement: () =>
                    context.read<CartCubit>().updateQuantity(item.food.id, -1),
                onRemove: () =>
                    context.read<CartCubit>().removeItem(item.food.id),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
