import 'package:equatable/equatable.dart';
import '../../../home/data/models/home_models.dart';

class FoodDetailsState extends Equatable {
  final FoodModel? food;
  final SizeModel? selectedSize;
  final List<AddOnModel> selectedAddOns;
  final int quantity;
  final double totalPrice;
  final bool isAddingToCart;
  final bool isAddedSuccessfully;
  final String? error;

  const FoodDetailsState({
    this.food,
    this.selectedSize,
    this.selectedAddOns = const [],
    this.quantity = 1,
    this.totalPrice = 0.0,
    this.isAddingToCart = false,
    this.isAddedSuccessfully = false,
    this.error,
  });

  FoodDetailsState copyWith({
    FoodModel? food,
    SizeModel? selectedSize,
    List<AddOnModel>? selectedAddOns,
    int? quantity,
    double? totalPrice,
    bool? isAddingToCart,
    bool? isAddedSuccessfully,
    String? error,
  }) {
    return FoodDetailsState(
      food: food ?? this.food,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      isAddedSuccessfully: isAddedSuccessfully ?? this.isAddedSuccessfully,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        food,
        selectedSize,
        selectedAddOns,
        quantity,
        totalPrice,
        isAddingToCart,
        isAddedSuccessfully,
        error,
      ];
}
