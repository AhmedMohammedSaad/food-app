import 'package:equatable/equatable.dart';
import '../../../home/data/models/home_models.dart';

class CartItemModel extends Equatable {
  final String id;
  final FoodModel food;
  final SizeModel? selectedSize;
  final List<AddOnModel> selectedAddOns;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.food,
    this.selectedSize,
    this.selectedAddOns = const [],
    this.quantity = 1,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // Handling joins from Supabase:
    // cart_items { id, quantity, foods(...), food_sizes(...), cart_item_addons(food_addons(...)) }
    
    final foodData = json['foods'] as Map<String, dynamic>;
    final sizeData = json['food_sizes'] as Map<String, dynamic>?;
    final addonsListData = json['cart_item_addons'] as List? ?? [];
    
    final selectedAddOns = addonsListData.map((addonJoin) {
      final addonData = addonJoin['food_addons'] as Map<String, dynamic>;
      return AddOnModel.fromJson(addonData);
    }).toList();

    return CartItemModel(
      id: json['id'] as String,
      food: FoodModel.fromJson(foodData),
      selectedSize: sizeData != null ? SizeModel.fromJson(sizeData) : null,
      selectedAddOns: selectedAddOns,
      quantity: json['quantity'] as int,
    );
  }

  double get totalPrice {
    double basePrice = food.price;
    if (selectedSize != null) {
      basePrice += selectedSize!.priceOffset;
    }
    double addOnsPrice = selectedAddOns.fold(0, (sum, addon) => sum + addon.price);
    return (basePrice + addOnsPrice) * quantity;
  }

  CartItemModel copyWith({
    String? id,
    FoodModel? food,
    SizeModel? selectedSize,
    List<AddOnModel>? selectedAddOns,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      food: food ?? this.food,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, food, selectedSize, selectedAddOns, quantity];
}
