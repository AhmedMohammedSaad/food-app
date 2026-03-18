import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

enum CartStatus { initial, loading, success, error }

class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final double totalPrice;
  final CartStatus status;
  final String? errorMessage;
  final double deliveryFee;
  final double tax;

  const CartState({
    required this.cartItems,
    required this.totalPrice,
    this.status = CartStatus.initial,
    this.errorMessage,
    this.deliveryFee = 2.99,
    this.tax = 1.50,
  });

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal + deliveryFee + tax;

  CartState copyWith({
    List<CartItemModel>? cartItems,
    double? totalPrice,
    CartStatus? status,
    String? errorMessage,
    double? deliveryFee,
    double? tax,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
    );
  }

  @override
  List<Object?> get props => [
        cartItems,
        totalPrice,
        status,
        errorMessage,
        deliveryFee,
        tax,
      ];
}
