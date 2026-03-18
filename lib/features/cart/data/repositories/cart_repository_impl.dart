import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';
import '../datasources/cart_remote_data_source.dart';
import '../models/cart_item_model.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final SupabaseClient supabaseClient;

  CartRepositoryImpl(this.remoteDataSource, this.supabaseClient);

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItems() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return const Left(ServerFailure('User not logged in'));
      
      final items = await remoteDataSource.getCartItems(userId);
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<CartItemModel>>> getCartItemsStream() {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value(const Left(ServerFailure('User not logged in')));
    }

    return remoteDataSource.getCartItemsStream(userId).map(
          (items) => Right<Failure, List<CartItemModel>>(items),
        ).handleError(
          (e) => Left<Failure, List<CartItemModel>>(ServerFailure(e.toString())),
        );
  }

  @override
  Future<Either<Failure, void>> addToCart({
    required FoodModel food,
    required SizeModel? size,
    required List<AddOnModel> addOns,
    required int quantity,
  }) async {
    try {
      await remoteDataSource.addToCart(
        food: food,
        size: size,
        addOns: addOns,
        quantity: quantity,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(String cartItemId, int quantity) async {
    try {
      await remoteDataSource.updateQuantity(cartItemId, quantity);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeItem(String cartItemId) async {
    try {
      await remoteDataSource.removeItem(cartItemId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return const Left(ServerFailure('User not logged in'));
      
      await remoteDataSource.clearCart(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
