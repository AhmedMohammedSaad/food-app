import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';

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
  FavoritesCubit() : super(FavoritesInitial());

  void getFavorites() async {
    emit(FavoritesLoading());
    try {
      // Mocking data for now
      await Future.delayed(const Duration(milliseconds: 500));
      emit(FavoritesSuccess(
        favoriteFoods: [
          const FoodModel(
            id: '1',
            name: 'Margherita Pizza',
            imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=800',
            price: 14.99,
            description: '',
            restaurantName: "Luigi's Pizzeria",
          ),
          const FoodModel(
            id: '2',
            name: 'Caesar Salad',
            imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=800',
            price: 8.99,
            description: '',
            restaurantName: 'Green Garden',
          ),
        ],
        favoriteRestaurants: [
          const RestaurantModel(
            id: '1',
            name: 'Pizza Hut',
            imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=800',
            rating: 4.5,
            deliveryTime: '25-35 min',
            distance: '1.2 km',
            tags: ['Pizza', 'Fast Food'],
            hasFreeDelivery: true,
          ),
        ],
      ));
    } catch (e) {
      emit(FavoritesFailure("Failed to load favorites"));
    }
  }

  void toggleFavoriteFood(FoodModel food) {
    if (state is FavoritesSuccess) {
      final currentState = state as FavoritesSuccess;
      final isFavorite = currentState.favoriteFoods.any((f) => f.id == food.id);
      
      List<FoodModel> updatedFoods;
      if (isFavorite) {
        updatedFoods = currentState.favoriteFoods.where((f) => f.id != food.id).toList();
      } else {
        updatedFoods = List.from(currentState.favoriteFoods)..add(food);
      }
      
      emit(currentState.copyWith(favoriteFoods: updatedFoods));
    }
  }

  void toggleFavoriteRestaurant(RestaurantModel restaurant) {
    if (state is FavoritesSuccess) {
      final currentState = state as FavoritesSuccess;
      final isFavorite = currentState.favoriteRestaurants.any((r) => r.id == restaurant.id);
      
      List<RestaurantModel> updatedRestaurants;
      if (isFavorite) {
        updatedRestaurants = currentState.favoriteRestaurants.where((r) => r.id != restaurant.id).toList();
      } else {
        updatedRestaurants = List.from(currentState.favoriteRestaurants)..add(restaurant);
      }
      
      emit(currentState.copyWith(favoriteRestaurants: updatedRestaurants));
    }
  }
}
