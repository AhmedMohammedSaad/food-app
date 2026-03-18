import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';

import '../../domain/repositories/favorites_repository.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final List<FoodModel> favoriteFoods;
  final List<RestaurantModel> favoriteRestaurants;

  FavoritesSuccess({
    required this.favoriteFoods,
    required this.favoriteRestaurants,
  });

  FavoritesSuccess copyWith({
    List<FoodModel>? favoriteFoods,
    List<RestaurantModel>? favoriteRestaurants,
  }) {
    return FavoritesSuccess(
      favoriteFoods: favoriteFoods ?? this.favoriteFoods,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
    );
  }
}

class FavoritesFailure extends FavoritesState {
  final String errorMessage;
  FavoritesFailure(this.errorMessage);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(FavoritesInitial());

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    
    final foodsResult = await repository.getFavoriteFoods();
    final restaurantsResult = await repository.getFavoriteRestaurants();

    foodsResult.fold(
      (failure) => emit(FavoritesFailure(failure.message)),
      (foods) {
        restaurantsResult.fold(
          (failure) => emit(FavoritesFailure(failure.message)),
          (restaurants) => emit(FavoritesSuccess(
            favoriteFoods: foods,
            favoriteRestaurants: restaurants,
          )),
        );
      },
    );
  }

  Future<void> removeFoodFromFavorites(String foodId) async {
    if (state is FavoritesSuccess) {
      final currentState = state as FavoritesSuccess;
      final result = await repository.removeFoodFromFavorites(foodId);
      
      result.fold(
        (failure) => null, // Handle error if needed
        (_) {
          final updatedFoods = currentState.favoriteFoods.where((f) => f.id != foodId).toList();
          emit(currentState.copyWith(favoriteFoods: updatedFoods));
        },
      );
    }
  }

  Future<void> removeRestaurantFromFavorites(String restaurantId) async {
    if (state is FavoritesSuccess) {
      final currentState = state as FavoritesSuccess;
      final result = await repository.removeRestaurantFromFavorites(restaurantId);
      
      result.fold(
        (failure) => null, // Handle error if needed
        (_) {
          final updatedRestaurants = currentState.favoriteRestaurants.where((r) => r.id != restaurantId).toList();
          emit(currentState.copyWith(favoriteRestaurants: updatedRestaurants));
        },
      );
    }
  }
}
