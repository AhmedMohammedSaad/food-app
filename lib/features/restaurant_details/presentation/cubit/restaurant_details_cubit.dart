import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';
import '../../domain/repositories/restaurant_details_repository.dart';

abstract class RestaurantDetailsState extends Equatable {
  final String selectedCategory;
  final List<FoodModel> menuItems;

  const RestaurantDetailsState({
    required this.selectedCategory,
    required this.menuItems,
  });

  @override
  List<Object?> get props => [selectedCategory, menuItems];
}

class RestaurantDetailsInitial extends RestaurantDetailsState {
  const RestaurantDetailsInitial()
      : super(selectedCategory: 'Main Dishes', menuItems: const []);
}

class RestaurantDetailsLoading extends RestaurantDetailsState {
  const RestaurantDetailsLoading({
    required super.selectedCategory,
    required super.menuItems,
  });
}

class RestaurantDetailsLoaded extends RestaurantDetailsState {
  const RestaurantDetailsLoaded({
    required super.selectedCategory,
    required super.menuItems,
  });
}

class RestaurantDetailsError extends RestaurantDetailsState {
  final String message;
  const RestaurantDetailsError({
    required this.message,
    required super.selectedCategory,
    required super.menuItems,
  });

  @override
  List<Object?> get props => [message, selectedCategory, menuItems];
}

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  final RestaurantDetailsRepository repository;

  RestaurantDetailsCubit(this.repository) : super(const RestaurantDetailsInitial());

  Future<void> loadMenu(String restaurantId) async {
    emit(RestaurantDetailsLoading(
      selectedCategory: state.selectedCategory,
      menuItems: state.menuItems,
    ));

    final result = await repository.getRestaurantMenu(restaurantId);

    result.fold(
      (failure) => emit(RestaurantDetailsError(
        message: failure.message,
        selectedCategory: state.selectedCategory,
        menuItems: state.menuItems,
      )),
      (menu) => emit(RestaurantDetailsLoaded(
        selectedCategory: state.selectedCategory,
        menuItems: menu,
      )),
    );
  }

  void selectCategory(String category) {
    if (state is RestaurantDetailsLoaded || state is RestaurantDetailsInitial) {
      emit(RestaurantDetailsLoaded(
        selectedCategory: category,
        menuItems: state.menuItems,
      ));
    } else if (state is RestaurantDetailsLoading) {
      emit(RestaurantDetailsLoading(
        selectedCategory: category,
        menuItems: state.menuItems,
      ));
    }
  }

  List<FoodModel> get filteredMenuItems {
    if (state.selectedCategory == 'Popular') {
       return state.menuItems; // Or implement popular logic
    }
    return state.menuItems.where((item) => item.menuCategory == state.selectedCategory).toList();
  }
}
