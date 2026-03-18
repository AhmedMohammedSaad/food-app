import 'package:flutter/material.dart';
import '../../../home/data/models/home_models.dart';


abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<RestaurantModel> restaurants;
  final List<FoodModel> foods;
  final String query;
  final String? sortBy;
  final RangeValues? priceRange;

  SearchSuccess({
    required this.restaurants,
    required this.foods,
    required this.query,
    this.sortBy,
    this.priceRange,
  });

  SearchSuccess copyWith({
    List<RestaurantModel>? restaurants,
    List<FoodModel>? foods,
    String? query,
    String? sortBy,
    RangeValues? priceRange,
  }) {
    return SearchSuccess(
      restaurants: restaurants ?? this.restaurants,
      foods: foods ?? this.foods,
      query: query ?? this.query,
      sortBy: sortBy ?? this.sortBy,
      priceRange: priceRange ?? this.priceRange,
    );
  }
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
