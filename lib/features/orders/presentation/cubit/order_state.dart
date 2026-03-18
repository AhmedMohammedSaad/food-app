import 'package:equatable/equatable.dart';
import 'package:test_food_app/features/orders/data/models/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrdersSuccess extends OrderState {
  final List<OrderModel> orders;

  const OrdersSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderPlaceLoading extends OrderState {}

class OrderPlaceSuccess extends OrderState {
  final OrderModel order;

  const OrderPlaceSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class OrdersError extends OrderState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
