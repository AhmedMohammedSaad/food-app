import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_footer_section.dart';
import '../widgets/cart_list_section.dart';
import '../widgets/cart_order_summary_section.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>()..getCartData(),
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
            'My Cart',
            style: AppTextStyle.font18SemiBoldCharcoal,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              CartListSection(),
              CartOrderSummarySection(),
            ],
          ),
        ),
        bottomNavigationBar: const CartFooterSection(),
      ),
    );
  }
}
