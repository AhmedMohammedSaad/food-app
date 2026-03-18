import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';
import '../../data/models/cart_item_model.dart';
import '../../domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  StreamSubscription? _cartSubscription;

  CartCubit(this.cartRepository)
      : super(const CartState(
          cartItems: [],
          totalPrice: 0.0,
        ));

  void loadCart() {
    emit(state.copyWith(status: CartStatus.loading));

    _cartSubscription?.cancel();
    _cartSubscription = cartRepository.getCartItemsStream().listen((result) {
      result.fold(
        (failure) => emit(state.copyWith(
          status: CartStatus.error,
          errorMessage: failure.message,
        )),
        (items) {
          emit(state.copyWith(
            status: CartStatus.success,
            cartItems: items,
          ));
          _calculateTotalPrice();
        },
      );
    });
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }

  Future<void> addToCart({
    required FoodModel food,
    required SizeModel? size,
    required List<AddOnModel> addOns,
    required int quantity,
  }) async {
    final result = await cartRepository.addToCart(
      food: food,
      size: size,
      addOns: addOns,
      quantity: quantity,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: failure.message,
      )),
      (_) => null, // Stream will handle the update
    );
  }

  Future<void> updateQuantity(String cartItemId, int change) async {
    final itemIndex = state.cartItems.indexWhere((item) => item.id == cartItemId);
    if (itemIndex != -1) {
      final currentQuantity = state.cartItems[itemIndex].quantity;
      final newQuantity = currentQuantity + change;
      
      if (newQuantity < 1) return;

      // Optimistic update
      final newItems = List<CartItemModel>.from(state.cartItems);
      newItems[itemIndex] = newItems[itemIndex].copyWith(quantity: newQuantity);
      emit(state.copyWith(cartItems: newItems));
      _calculateTotalPrice();

      final result = await cartRepository.updateQuantity(cartItemId, newQuantity);
      if (result.isLeft()) {
        loadCart(); // Revert on failure
        emit(state.copyWith(
          status: CartStatus.error,
          errorMessage: 'Failed to update quantity',
        ));
      }
    }
  }

  Future<void> removeItem(String cartItemId) async {
    // Optimistic update
    final newItems = state.cartItems.where((item) => item.id != cartItemId).toList();
    emit(state.copyWith(cartItems: newItems));
    _calculateTotalPrice();

    final result = await cartRepository.removeItem(cartItemId);
    if (result.isLeft()) {
      loadCart(); // Revert on failure
      emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: 'Failed to remove item',
      ));
    }
  }

  Future<void> clearCart() async {
    // Optimistic update
    emit(state.copyWith(cartItems: []));
    _calculateTotalPrice();

    final result = await cartRepository.clearCart();
    if (result.isLeft()) {
      loadCart(); // Revert on failure
      emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: 'Failed to clear cart',
      ));
    }
  }
  void _calculateTotalPrice() {
    double total = state.cartItems.fold(0, (sum, item) => sum + item.totalPrice);
    emit(state.copyWith(totalPrice: total));
  }
}
