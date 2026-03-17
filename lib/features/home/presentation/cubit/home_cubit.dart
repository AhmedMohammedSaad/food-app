import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/models/home_models.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());

  List<CategoryModel> _allCategories = [];
  List<RestaurantModel> _allRestaurants = [];
  List<FoodModel> _allRecommendedFoods = [];

  void getHomeData() async {
    emit(HomeLoading());

    final results = await Future.wait([
      homeRepository.getCategories(),
      homeRepository.getRestaurants(),
      homeRepository.getRecommendedFoods(),
    ]);

    final categoriesResult = results[0] as dynamic; // Either<Failure, List<CategoryModel>>
    final restaurantsResult = results[1] as dynamic; // Either<Failure, List<RestaurantModel>>
    final foodsResult = results[2] as dynamic; // Either<Failure, List<FoodModel>>

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
        (restaurants) => _allRestaurants = restaurants,
      );
    }

    if (!hasError) {
      foodsResult.fold(
        (failure) {
          hasError = true;
          errorMessage = failure.message;
        },
        (foods) => _allRecommendedFoods = foods,
      );
    }

    if (hasError) {
      emit(HomeError(errorMessage));
    } else {
      emit(HomeSuccess(
        categories: _allCategories,
        restaurants: _allRestaurants,
        recommendedFoods: _allRecommendedFoods,
      ));
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
