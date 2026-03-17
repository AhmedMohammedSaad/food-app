import '../../../home/data/models/home_models.dart';

class CartItemModel {
  final FoodModel food;
  int quantity;

  CartItemModel({
    required this.food,
    this.quantity = 1,
  });

  double get totalPrice => food.price * quantity;

  CartItemModel copyWith({
    FoodModel? food,
    int? quantity,
  }) {
    return CartItemModel(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }
}
