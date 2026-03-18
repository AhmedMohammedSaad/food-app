import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/models/home_models.dart';
import 'restaurants_view_all_state.dart';

class RestaurantsViewAllCubit extends Cubit<RestaurantsViewAllState> {
  final HomeRepository _homeRepository;
  int _offset = 0;
  final int _limit = 10;

  RestaurantsViewAllCubit(this._homeRepository) : super(RestaurantsViewAllInitial());

  Future<void> getInitialRestaurants(List<RestaurantModel> initialData) async {
    _offset = initialData.length;
    emit(RestaurantsViewAllSuccess(
      restaurants: initialData,
      hasMore: initialData.length >= _limit,
    ));
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! RestaurantsViewAllSuccess || currentState.isMoreLoading || !currentState.hasMore) return;

    emit(currentState.copyWith(isMoreLoading: true));

    final result = await _homeRepository.getRestaurants(limit: _limit, offset: _offset);

    result.fold(
      (failure) => emit(RestaurantsViewAllError(failure.message)),
      (newRestaurants) {
        if (newRestaurants.isEmpty) {
          emit(currentState.copyWith(isMoreLoading: false, hasMore: false));
        } else {
          _offset += newRestaurants.length;
          emit(currentState.copyWith(
            restaurants: [...currentState.restaurants, ...newRestaurants],
            isMoreLoading: false,
            hasMore: newRestaurants.length >= _limit,
          ));
        }
      },
    );
  }
}
