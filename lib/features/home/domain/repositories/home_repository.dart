import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/home_models.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants({int limit = 10, int offset = 0});
  Future<Either<Failure, List<FoodModel>>> getRecommendedFoods({int limit = 10, int offset = 0});
}
