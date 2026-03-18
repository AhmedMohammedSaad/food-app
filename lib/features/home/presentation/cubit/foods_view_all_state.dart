import '../../data/models/home_models.dart';

abstract class FoodsViewAllState {}

class FoodsViewAllInitial extends FoodsViewAllState {}

class FoodsViewAllLoading extends FoodsViewAllState {}

class FoodsViewAllSuccess extends FoodsViewAllState {
  final List<FoodModel> foods;
  final bool isMoreLoading;
  final bool hasMore;

  FoodsViewAllSuccess({
    required this.foods,
    this.isMoreLoading = false,
    this.hasMore = true,
  });

  FoodsViewAllSuccess copyWith({
    List<FoodModel>? foods,
    bool? isMoreLoading,
    bool? hasMore,
  }) {
    return FoodsViewAllSuccess(
      foods: foods ?? this.foods,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class FoodsViewAllError extends FoodsViewAllState {
  final String message;
  FoodsViewAllError(this.message);
}
