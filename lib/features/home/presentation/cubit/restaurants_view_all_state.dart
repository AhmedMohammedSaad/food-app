import '../../data/models/home_models.dart';

abstract class RestaurantsViewAllState {}

class RestaurantsViewAllInitial extends RestaurantsViewAllState {}

class RestaurantsViewAllLoading extends RestaurantsViewAllState {}

class RestaurantsViewAllSuccess extends RestaurantsViewAllState {
  final List<RestaurantModel> restaurants;
  final bool isMoreLoading;
  final bool hasMore;

  RestaurantsViewAllSuccess({
    required this.restaurants,
    this.isMoreLoading = false,
    this.hasMore = true,
  });

  RestaurantsViewAllSuccess copyWith({
    List<RestaurantModel>? restaurants,
    bool? isMoreLoading,
    bool? hasMore,
  }) {
    return RestaurantsViewAllSuccess(
      restaurants: restaurants ?? this.restaurants,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class RestaurantsViewAllError extends RestaurantsViewAllState {
  final String message;
  RestaurantsViewAllError(this.message);
}
