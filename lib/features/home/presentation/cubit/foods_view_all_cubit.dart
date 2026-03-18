import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/models/home_models.dart';
import 'foods_view_all_state.dart';

class FoodsViewAllCubit extends Cubit<FoodsViewAllState> {
  final HomeRepository _homeRepository;
  int _offset = 0;
  final int _limit = 10;

  FoodsViewAllCubit(this._homeRepository) : super(FoodsViewAllInitial());

  Future<void> getInitialFoods(List<FoodModel> initialData) async {
    _offset = initialData.length;
    emit(FoodsViewAllSuccess(
      foods: initialData,
      hasMore: initialData.length >= _limit,
    ));
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! FoodsViewAllSuccess || currentState.isMoreLoading || !currentState.hasMore) return;

    emit(currentState.copyWith(isMoreLoading: true));

    final result = await _homeRepository.getRecommendedFoods(limit: _limit, offset: _offset);

    result.fold(
      (failure) => emit(FoodsViewAllError(failure.message)),
      (newFoods) {
        if (newFoods.isEmpty) {
          emit(currentState.copyWith(isMoreLoading: false, hasMore: false));
        } else {
          _offset += newFoods.length;
          emit(currentState.copyWith(
            foods: [...currentState.foods, ...newFoods],
            isMoreLoading: false,
            hasMore: newFoods.length >= _limit,
          ));
        }
      },
    );
  }
}
