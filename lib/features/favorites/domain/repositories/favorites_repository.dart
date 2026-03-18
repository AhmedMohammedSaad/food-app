import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<FoodModel>>> getFavoriteFoods();
  Future<Either<Failure, List<RestaurantModel>>> getFavoriteRestaurants();
  Future<Either<Failure, void>> addFoodToFavorites(String foodId);
  Future<Either<Failure, void>> removeFoodFromFavorites(String foodId);
  Future<Either<Failure, void>> addRestaurantToFavorites(String restaurantId);
  Future<Either<Failure, void>> removeRestaurantFromFavorites(String restaurantId);
  Future<Either<Failure, bool>> isFoodFavorite(String foodId);
  Future<Either<Failure, bool>> isRestaurantFavorite(String restaurantId);
}
