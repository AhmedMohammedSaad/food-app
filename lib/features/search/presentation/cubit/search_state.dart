import '../../../home/data/models/home_models.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<RestaurantModel> restaurants;
  final List<FoodModel> foods;
  final String query;

  SearchSuccess({
    required this.restaurants,
    required this.foods,
    required this.query,
  });

  SearchSuccess copyWith({
    List<RestaurantModel>? restaurants,
    List<FoodModel>? foods,
    String? query,
  }) {
    return SearchSuccess(
      restaurants: restaurants ?? this.restaurants,
      foods: foods ?? this.foods,
      query: query ?? this.query,
    );
  }
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
