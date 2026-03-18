import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';

import '../../domain/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  List<RestaurantModel> _allRestaurants = [];
  List<FoodModel> _allFoods = [];

  SearchCubit(this.repository) : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final restaurantsResult = await repository.searchRestaurants(query);

    restaurantsResult.fold(
      (failure) => emit(SearchError(failure.message)),
      (restaurants) async {
        final foodsResult = await repository.searchFoods(query);
        foodsResult.fold(
          (failure) => emit(SearchError(failure.message)),
          (foods) {
            _allRestaurants = restaurants;
            _allFoods = foods;
            emit(SearchSuccess(
              restaurants: restaurants,
              foods: foods,
              query: query,
            ));
          },
        );
      },
    );
  }

  void applyFilters(String sortBy, RangeValues priceRange) {
    if (state is SearchSuccess) {
      final currentState = state as SearchSuccess;

      List<RestaurantModel> filteredRestaurants = List.from(_allRestaurants);
      List<FoodModel> filteredFoods = List.from(_allFoods);

      // Apply price filter to foods
      filteredFoods = filteredFoods.where((food) {
        return food.price >= priceRange.start && food.price <= priceRange.end;
      }).toList();

      // Apply sorting
      if (sortBy == 'Rating') {
        filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
        filteredFoods.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (sortBy == 'Cheapest') {
        filteredFoods.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == 'Nearest') {
        filteredRestaurants.sort((a, b) => a.deliveryTime.compareTo(b.deliveryTime));
      }

      emit(currentState.copyWith(
        restaurants: filteredRestaurants,
        foods: filteredFoods,
        sortBy: sortBy,
        priceRange: priceRange,
      ));
    }
  }
}
