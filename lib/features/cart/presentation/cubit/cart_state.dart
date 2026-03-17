import '../../data/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartItemModel> items;
  final double deliveryFee;
  final double tax;

  CartSuccess({
    required this.items,
    this.deliveryFee = 2.99,
    this.tax = 1.50,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal + deliveryFee + tax;

  CartSuccess copyWith({
    List<CartItemModel>? items,
    double? deliveryFee,
    double? tax,
  }) {
    return CartSuccess(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
    );
  }
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
