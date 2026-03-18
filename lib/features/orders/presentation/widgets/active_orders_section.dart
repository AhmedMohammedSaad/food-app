import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import 'package:test_food_app/features/orders/data/models/order_model.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersError) {
          return Center(child: Text(state.message));
        } else if (state is OrdersSuccess) {
          if (state.orders.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  Icon(Icons.receipt_long, size: 64.r, color: AppColors.slate300),
                  SizedBox(height: 16.h),
                  Text(
                    'No orders yet',
                    style: AppTextStyle.font16SemiBoldCharcoal,
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Orders', style: AppTextStyle.font18SemiBoldCharcoal),
              SizedBox(height: 16.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.orders.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return _OrderCard(order: order);
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.orderTracking,
          arguments: order.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.slate200,
                image: DecorationImage(
                  image: NetworkImage(
                    order.restaurantImageUrl ??
                        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.restaurantName ?? 'Restaurant',
                    style: AppTextStyle.font16SemiBoldCharcoal,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${order.items.length} items • \$${order.totalAmount.toStringAsFixed(2)}',
                    style: AppTextStyle.font14RegularSlate600,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          _getStatusText(order.status),
                          style: AppTextStyle.font12MediumSlate300.copyWith(
                            color: _getStatusColor(order.status),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.slate400),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.received:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.orange;
      case OrderStatus.onTheWay:
        return AppColors.primary;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.received:
        return 'Received';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.onTheWay:
        return 'On the Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
