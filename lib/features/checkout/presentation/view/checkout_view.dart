import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../orders/presentation/cubit/order_cubit.dart';
import '../../../orders/presentation/cubit/order_state.dart';
import '../widgets/checkout_footer_section.dart';
import '../widgets/checkout_order_summary_section.dart';
import '../widgets/delivery_address_section.dart';
import '../widgets/payment_method_section.dart';
import '../widgets/promo_code_section.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<OrderCubit>()),
        BlocProvider.value(value: getIt<CartCubit>()),
      ],
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderPlaceSuccess) {
            context.read<CartCubit>().clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully!')),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.orderTracking,
              (route) => route.isFirst,
              arguments: state.order.id,
            );
          } else if (state is OrdersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Checkout',
              style: AppTextStyle.font18SemiBoldCharcoal,
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const DeliveryAddressSection(),
                    const PaymentMethodSection(),
                    const PromoCodeSection(),
                    CheckoutOrderSummarySection(
                      subtotal: cartState.subtotal,
                      deliveryFee: cartState.deliveryFee,
                      tax: cartState.tax,
                      total: cartState.total,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: const CheckoutFooterSection(),
        ),
      ),
    );
  }
}
