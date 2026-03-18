import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';
import '../../domain/repositories/restaurant_details_repository.dart';

import '../../../../features/favorites/domain/repositories/favorites_repository.dart';

abstract class RestaurantDetailsState extends Equatable {
  final String selectedCategory;
  final List<FoodModel> menuItems;
  final bool isFavorite;

  const RestaurantDetailsState({
    required this.selectedCategory,
    required this.menuItems,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [selectedCategory, menuItems, isFavorite];
}

class RestaurantDetailsInitial extends RestaurantDetailsState {
  const RestaurantDetailsInitial()
      : super(selectedCategory: 'Main Dishes', menuItems: const []);
}

class RestaurantDetailsLoading extends RestaurantDetailsState {
  const RestaurantDetailsLoading({
    required super.selectedCategory,
    required super.menuItems,
    super.isFavorite,
  });
}

class RestaurantDetailsLoaded extends RestaurantDetailsState {
  const RestaurantDetailsLoaded({
    required super.selectedCategory,
    required super.menuItems,
    super.isFavorite,
  });

  RestaurantDetailsLoaded copyWith({
    String? selectedCategory,
    List<FoodModel>? menuItems,
    bool? isFavorite,
  }) {
    return RestaurantDetailsLoaded(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      menuItems: menuItems ?? this.menuItems,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class RestaurantDetailsError extends RestaurantDetailsState {
  final String message;
  const RestaurantDetailsError({
    required this.message,
    required super.selectedCategory,
    required super.menuItems,
    super.isFavorite,
  });

  @override
  List<Object?> get props => [message, selectedCategory, menuItems, isFavorite];
}

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  final RestaurantDetailsRepository repository;
  final FavoritesRepository favoritesRepository;

  RestaurantDetailsCubit(this.repository, this.favoritesRepository)
      : super(const RestaurantDetailsInitial());

  Future<void> loadRestaurantDetails(String restaurantId) async {
    emit(RestaurantDetailsLoading(
      selectedCategory: state.selectedCategory,
      menuItems: state.menuItems,
      isFavorite: state.isFavorite,
    ));

    final menuResult = await repository.getRestaurantMenu(restaurantId);
    final favoriteResult = await favoritesRepository.isRestaurantFavorite(restaurantId);

    bool isFavorite = state.isFavorite;
    favoriteResult.fold((_) => null, (fav) => isFavorite = fav);

    menuResult.fold(
      (failure) => emit(RestaurantDetailsError(
        message: failure.message,
        selectedCategory: state.selectedCategory,
        menuItems: state.menuItems,
        isFavorite: isFavorite,
      )),
      (menu) => emit(RestaurantDetailsLoaded(
        selectedCategory: state.selectedCategory,
        menuItems: menu,
        isFavorite: isFavorite,
      )),
    );
  }

  Future<void> toggleFavorite(String restaurantId) async {
    if (state is RestaurantDetailsLoaded) {
      final currentState = state as RestaurantDetailsLoaded;
      final newFavoriteStatus = !currentState.isFavorite;

      emit(currentState.copyWith(isFavorite: newFavoriteStatus));

      final result = newFavoriteStatus
          ? await favoritesRepository.addRestaurantToFavorites(restaurantId)
          : await favoritesRepository.removeRestaurantFromFavorites(restaurantId);

      result.fold(
        (failure) => emit(currentState.copyWith(isFavorite: !newFavoriteStatus)), // Revert on failure
        (_) => null,
      );
    }
  }

  void selectCategory(String category) {
    if (state is RestaurantDetailsLoaded) {
      emit((state as RestaurantDetailsLoaded).copyWith(selectedCategory: category));
    } else if (state is RestaurantDetailsLoading) {
      emit(RestaurantDetailsLoading(
        selectedCategory: category,
        menuItems: state.menuItems,
        isFavorite: state.isFavorite,
      ));
    }
  }

  List<FoodModel> get filteredMenuItems {
    if (state.selectedCategory == 'Popular') {
      return state.menuItems;
    }
    return state.menuItems
        .where((item) => item.menuCategory == state.selectedCategory)
        .toList();
  }
}
