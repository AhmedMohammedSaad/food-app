import 'package:flutter/material.dart';
import '../../data/models/home_models.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CategoryModel> categories;
  final List<RestaurantModel> restaurants;
  final List<FoodModel> recommendedFoods;
  final String? selectedCategoryId;
  final String searchQuery;
  final String? sortBy;
  final RangeValues? priceRange;
  final bool isMoreRestaurantsLoading;
  final bool isMoreFoodsLoading;
  final bool hasMoreRestaurants;
  final bool hasMoreFoods;

  HomeSuccess({
    required this.categories,
    required this.restaurants,
    required this.recommendedFoods,
    this.selectedCategoryId,
    this.searchQuery = '',
    this.sortBy,
    this.priceRange,
    this.isMoreRestaurantsLoading = false,
    this.isMoreFoodsLoading = false,
    this.hasMoreRestaurants = true,
    this.hasMoreFoods = true,
  });

  HomeSuccess copyWith({
    List<CategoryModel>? categories,
    List<RestaurantModel>? restaurants,
    List<FoodModel>? recommendedFoods,
    String? selectedCategoryId,
    bool clearSelectedCategory = false,
    String? searchQuery,
    String? sortBy,
    RangeValues? priceRange,
    bool? isMoreRestaurantsLoading,
    bool? isMoreFoodsLoading,
    bool? hasMoreRestaurants,
    bool? hasMoreFoods,
  }) {
    return HomeSuccess(
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      recommendedFoods: recommendedFoods ?? this.recommendedFoods,
      selectedCategoryId:
          clearSelectedCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      priceRange: priceRange ?? this.priceRange,
      isMoreRestaurantsLoading: isMoreRestaurantsLoading ?? this.isMoreRestaurantsLoading,
      isMoreFoodsLoading: isMoreFoodsLoading ?? this.isMoreFoodsLoading,
      hasMoreRestaurants: hasMoreRestaurants ?? this.hasMoreRestaurants,
      hasMoreFoods: hasMoreFoods ?? this.hasMoreFoods,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
