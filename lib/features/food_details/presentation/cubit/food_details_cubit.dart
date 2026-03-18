import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_food_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:test_food_app/features/home/data/models/home_models.dart';
import 'food_details_state.dart';

import '../../../../features/favorites/domain/repositories/favorites_repository.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final CartRepository cartRepository;
  final FavoritesRepository favoritesRepository;

  FoodDetailsCubit(this.cartRepository, this.favoritesRepository)
      : super(const FoodDetailsState());

  Future<void> init(FoodModel food) async {
    emit(
      state.copyWith(
        food: food,
        selectedSize: food.sizes.isNotEmpty ? food.sizes.first : null,
        totalPrice: food.price,
        quantity: 1,
      ),
    );

    // Check if favorite
    final result = await favoritesRepository.isFoodFavorite(food.id);
    result.fold(
      (_) => null,
      (isFav) => emit(state.copyWith(isFavorite: isFav)),
    );
  }

  Future<void> toggleFavorite() async {
    if (state.food == null) return;

    final newFavoriteStatus = !state.isFavorite;
    emit(state.copyWith(isFavorite: newFavoriteStatus));

    final result = newFavoriteStatus
        ? await favoritesRepository.addFoodToFavorites(state.food!.id)
        : await favoritesRepository.removeFoodFromFavorites(state.food!.id);

    result.fold(
      (failure) => emit(state.copyWith(isFavorite: !newFavoriteStatus)), // Revert on failure
      (_) => null,
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
