import 'package:equatable/equatable.dart';
import '../../../home/data/models/home_models.dart';

class FoodDetailsState extends Equatable {
  final FoodModel? food;
  final SizeModel? selectedSize;
  final List<AddOnModel> selectedAddOns;
  final int quantity;
  final double totalPrice;

  const FoodDetailsState({
    this.food,
    this.selectedSize,
    this.selectedAddOns = const [],
    this.quantity = 1,
    this.totalPrice = 0.0,
  });

  FoodDetailsState copyWith({
    FoodModel? food,
    SizeModel? selectedSize,
    List<AddOnModel>? selectedAddOns,
    int? quantity,
    double? totalPrice,
  }) {
    return FoodDetailsState(
      food: food ?? this.food,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [food, selectedSize, selectedAddOns, quantity, totalPrice];
}
