import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_food_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:test_food_app/features/home/data/models/home_models.dart';
import 'food_details_state.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final CartRepository cartRepository;

  FoodDetailsCubit(this.cartRepository) : super(const FoodDetailsState());

  void init(FoodModel food) {
    emit(
      state.copyWith(
        food: food,
        selectedSize: food.sizes.isNotEmpty ? food.sizes.first : null,
        totalPrice: food.price,
        quantity: 1,
      ),
    );
  }

  void selectSize(SizeModel size) {
    emit(state.copyWith(selectedSize: size));
    _calculateTotalPrice();
  }

  void toggleAddOn(AddOnModel addOn) {
    final updatedAddOns = List<AddOnModel>.from(state.selectedAddOns);
    if (updatedAddOns.contains(addOn)) {
      updatedAddOns.remove(addOn);
    } else {
      updatedAddOns.add(addOn);
    }
    emit(state.copyWith(selectedAddOns: updatedAddOns));
    _calculateTotalPrice();
  }

  void updateQuantity(int delta) {
    final newQuantity = state.quantity + delta;
    if (newQuantity >= 1) {
      emit(state.copyWith(quantity: newQuantity));
      _calculateTotalPrice();
    }
  }

  Future<void> addToCart() async {
    if (state.food == null) return;

    emit(state.copyWith(isAddingToCart: true));

    final result = await cartRepository.addToCart(
      food: state.food!,
      size: state.selectedSize,
      addOns: state.selectedAddOns,
      quantity: state.quantity,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isAddingToCart: false, error: failure.message)),
      (_) => emit(
        state.copyWith(isAddingToCart: false, isAddedSuccessfully: true),
      ),
    );
  }

  void _calculateTotalPrice() {
    if (state.food == null) return;

    double basePrice = state.food!.price;

    // Add size offset if any
    if (state.selectedSize != null) {
      basePrice += state.selectedSize!.priceOffset;
    }

    // Add selected add-ons
    double addOnsPrice = 0;
    for (var addOn in state.selectedAddOns) {
      addOnsPrice += addOn.price;
    }

    final total = (basePrice + addOnsPrice) * state.quantity;
    emit(state.copyWith(totalPrice: total));
  }
}
