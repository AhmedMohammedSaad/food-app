import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../domain/repositories/order_repository.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  StreamSubscription? _ordersSubscription;

  OrderCubit(this.orderRepository) : super(OrderInitial());

  void fetchOrders() {
    emit(OrdersLoading());

    _ordersSubscription?.cancel();
    _ordersSubscription = orderRepository.getOrdersStream().listen((result) {
      result.fold(
        (failure) => emit(OrdersError(failure.message)),
        (orders) => emit(OrdersSuccess(orders)),
      );
    });
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }

  Future<void> placeOrder({
    required String restaurantId,
    required String? addressId,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double totalAmount,
    required String paymentMethod,
    required List<CartItemModel> cartItems,
  }) async {
    emit(OrderPlaceLoading());
    final result = await orderRepository.placeOrder(
      restaurantId: restaurantId,
      addressId: addressId,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      cartItems: cartItems,
    );

    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (orderModel) => emit(OrderPlaceSuccess(orderModel)),
    );
  }
}
