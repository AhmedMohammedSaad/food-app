import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../features/cart/data/models/cart_item_model.dart';
import 'package:test_food_app/features/orders/data/models/order_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getOrders();
  Stream<Either<Failure, List<OrderModel>>> getOrdersStream();
  Future<Either<Failure, OrderModel>> placeOrder({
    required String restaurantId,
    required String? addressId,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double totalAmount,
    required String paymentMethod,
    required List<CartItemModel> cartItems,
  });
}
