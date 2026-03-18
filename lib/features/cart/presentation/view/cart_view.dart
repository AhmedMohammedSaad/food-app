import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_footer_section.dart';
import '../widgets/cart_list_section.dart';
import '../widgets/cart_loading_skeleton.dart';
import '../widgets/cart_order_summary_section.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>()..loadCart(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          title: Text('My Cart', style: AppTextStyle.font18SemiBoldCharcoal),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.status == CartStatus.loading && state.cartItems.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: CartLoadingSkeleton(),
              );
            }

            if (state.status == CartStatus.error && state.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'Error loading cart'),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().loadCart(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state.cartItems.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async => context.read<CartCubit>().loadCart(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64.r,
                            color: AppColors.slate300,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Your cart is empty',
                            style: AppTextStyle.font18SemiBoldCharcoal,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Add some items to get started',
                            style: AppTextStyle.font14RegularSlate600,
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<CartCubit>().loadCart(),
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => context.read<CartCubit>().loadCart(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: const [
                    CartListSection(),
                    CartOrderSummarySection(),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const CartFooterSection(),
      ),
    );
  }
}
