import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../../../features/cart/data/models/cart_item_model.dart';
import '../datasources/order_remote_data_source.dart';
import 'package:test_food_app/features/orders/data/models/order_model.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final SupabaseClient supabaseClient;

  OrderRepositoryImpl(this.remoteDataSource, this.supabaseClient);

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return const Left(ServerFailure('User not logged in'));

      final orders = await remoteDataSource.getOrders(userId);
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<OrderModel>>> getOrdersStream() {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value(const Left(ServerFailure('User not logged in')));
    }

    return remoteDataSource.getOrdersStream(userId).map(
          (orders) => Right<Failure, List<OrderModel>>(orders),
        ).handleError(
          (e) => Left<Failure, List<OrderModel>>(ServerFailure(e.toString())),
        );
  }

  @override
  Future<Either<Failure, OrderModel>> placeOrder({
    required String restaurantId,
    required String? addressId,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double totalAmount,
    required String paymentMethod,
    required List<CartItemModel> cartItems,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return const Left(ServerFailure('User not logged in'));

      final order = await remoteDataSource.placeOrder(
        userId: userId,
        restaurantId: restaurantId,
        addressId: addressId,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        tax: tax,
        totalAmount: totalAmount,
        paymentMethod: paymentMethod,
        cartItems: cartItems,
      );
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
