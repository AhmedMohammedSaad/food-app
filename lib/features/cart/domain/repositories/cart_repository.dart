import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';
import '../../data/models/cart_item_model.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemModel>>> getCartItems();
  Stream<Either<Failure, List<CartItemModel>>> getCartItemsStream();
  Future<Either<Failure, void>> addToCart({
    required FoodModel food,
    required SizeModel? size,
    required List<AddOnModel> addOns,
    required int quantity,
  });
  Future<Either<Failure, void>> updateQuantity(String cartItemId, int quantity);
  Future<Either<Failure, void>> removeItem(String cartItemId);
  Future<Either<Failure, void>> clearCart();
}
