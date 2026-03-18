import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

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
}
