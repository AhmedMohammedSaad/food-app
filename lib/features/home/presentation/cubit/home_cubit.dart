import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/models/home_models.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());

  List<CategoryModel> _allCategories = [];
  List<RestaurantModel> _allRestaurants = [];
  List<FoodModel> _allRecommendedFoods = [];

  int _restaurantOffset = 0;
  int _foodOffset = 0;
  final int _limit = 10;

  void getHomeData() async {
    emit(HomeLoading());
    _restaurantOffset = 0;
    _foodOffset = 0;

    final results = await Future.wait([
      homeRepository.getCategories(),
      homeRepository.getRestaurants(limit: _limit, offset: _restaurantOffset),
      homeRepository.getRecommendedFoods(limit: _limit, offset: _foodOffset),
    ]);

    final categoriesResult = results[0] as Either<Failure, List<CategoryModel>>;
    final restaurantsResult = results[1] as Either<Failure, List<RestaurantModel>>;
    final foodsResult = results[2] as Either<Failure, List<FoodModel>>;

    bool hasError = false;
    String errorMessage = '';

    categoriesResult.fold(
      (failure) {
        hasError = true;
        errorMessage = failure.message;
      },
      (categories) => _allCategories = categories,
    );

    if (!hasError) {
      restaurantsResult.fold(
        (failure) {
          hasError = true;
          errorMessage = failure.message;
        },
        (restaurants) {
          _allRestaurants = List.from(restaurants);
          _restaurantOffset += restaurants.length;
        },
      );
    }

    if (!hasError) {
      foodsResult.fold(
        (failure) {
          hasError = true;
          errorMessage = failure.message;
        },
        (foods) {
          _allRecommendedFoods = List.from(foods);
          _foodOffset += foods.length;
        },
      );
    }

    if (hasError) {
      emit(HomeError(errorMessage));
    } else {
      emit(HomeSuccess(
        categories: _allCategories,
        restaurants: _allRestaurants,
        recommendedFoods: _allRecommendedFoods,
        hasMoreRestaurants: _allRestaurants.length >= _limit,
        hasMoreFoods: _allRecommendedFoods.length >= _limit,
      ));
    }
  }

  void loadMoreRestaurants() async {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;
      if (currentState.isMoreRestaurantsLoading || !currentState.hasMoreRestaurants) return;

      emit(currentState.copyWith(isMoreRestaurantsLoading: true));

      final result = await homeRepository.getRestaurants(limit: _limit, offset: _restaurantOffset);

      result.fold(
        (failure) => emit(currentState.copyWith(isMoreRestaurantsLoading: false)),
        (newRestaurants) {
          if (newRestaurants.isEmpty) {
            emit(currentState.copyWith(isMoreRestaurantsLoading: false, hasMoreRestaurants: false));
          } else {
            _allRestaurants.addAll(newRestaurants);
            _restaurantOffset += newRestaurants.length;
            emit(currentState.copyWith(
              restaurants: List.from(_allRestaurants),
              isMoreRestaurantsLoading: false,
              hasMoreRestaurants: newRestaurants.length >= _limit,
            ));
          }
        },
      );
    }
  }

  void loadMoreRecommendedFoods() async {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;
      if (currentState.isMoreFoodsLoading || !currentState.hasMoreFoods) return;

      emit(currentState.copyWith(isMoreFoodsLoading: true));

      final result = await homeRepository.getRecommendedFoods(limit: _limit, offset: _foodOffset);

      result.fold(
        (failure) => emit(currentState.copyWith(isMoreFoodsLoading: false)),
        (newFoods) {
          if (newFoods.isEmpty) {
            emit(currentState.copyWith(isMoreFoodsLoading: false, hasMoreFoods: false));
          } else {
            _allRecommendedFoods.addAll(newFoods);
            _foodOffset += newFoods.length;
            emit(currentState.copyWith(
              recommendedFoods: List.from(_allRecommendedFoods),
              isMoreFoodsLoading: false,
              hasMoreFoods: newFoods.length >= _limit,
            ));
          }
        },
      );
    }
  }

  void filterByCategory(String? categoryId) {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;
      
      // If same category clicked, toggle off
      final newCategoryId = currentState.selectedCategoryId == categoryId ? null : categoryId;
      
      _applyFilters(newCategoryId, currentState.searchQuery);
    }
  }

  void search(String query) {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;
      _applyFilters(currentState.selectedCategoryId, query);
    }
  }

  void applyAdvancedFilters({
    String? sortBy,
    RangeValues? priceRange,
  }) {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;
      _applyFilters(
        currentState.selectedCategoryId,
        currentState.searchQuery,
        sortBy: sortBy ?? currentState.sortBy,
        priceRange: priceRange ?? currentState.priceRange,
      );
    }
  }

  void _applyFilters(
    String? categoryId,
    String query, {
    String? sortBy,
    RangeValues? priceRange,
  }) {
    List<RestaurantModel> filteredRestaurants = _allRestaurants;
    List<FoodModel> filteredFoods = _allRecommendedFoods;

    // Filter by category
    if (categoryId != null) {
      final category = _allCategories.firstWhere((c) => c.id == categoryId);
      final categoryName = category.name.toLowerCase();

      filteredRestaurants = _allRestaurants.where((r) {
        return r.tags.any((tag) => tag.toLowerCase().contains(categoryName)) ||
            r.name.toLowerCase().contains(categoryName);
      }).toList();

      filteredFoods = _allRecommendedFoods.where((f) {
        return f.name.toLowerCase().contains(categoryName) ||
            f.description.toLowerCase().contains(categoryName);
      }).toList();
    }

    // Filter by search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filteredRestaurants = filteredRestaurants.where((r) {
        return r.name.toLowerCase().contains(q) ||
            r.tags.any((tag) => tag.toLowerCase().contains(q));
      }).toList();

      filteredFoods = filteredFoods.where((f) {
        return f.name.toLowerCase().contains(q) ||
            f.description.toLowerCase().contains(q);
      }).toList();
    }

    // Filter by price range
    if (priceRange != null) {
      filteredFoods = filteredFoods.where((f) {
        return f.price >= priceRange.start && f.price <= priceRange.end;
      }).toList();
    }

    // Sorting
    if (sortBy != null) {
      if (sortBy == "Rating") {
        filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (sortBy == "Cheapest") {
        filteredFoods.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == "Nearest") {
        filteredRestaurants.sort((a, b) => a.distance.compareTo(b.distance));
      }
    }

    emit((state as HomeSuccess).copyWith(
      restaurants: List.from(filteredRestaurants),
      recommendedFoods: List.from(filteredFoods),
      selectedCategoryId: categoryId,
      clearSelectedCategory: categoryId == null,
      searchQuery: query,
      sortBy: sortBy,
      priceRange: priceRange,
    ));
  }
}
