import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../cubit/order_cubit.dart';
import '../widgets/active_orders_section.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrderCubit>()..fetchOrders(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          title: Text('My Orders', style: AppTextStyle.font20SemiBoldCharcoal),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async => context.read<OrderCubit>().fetchOrders(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ActiveOrdersSection(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
