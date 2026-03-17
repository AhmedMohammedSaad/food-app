import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/home_models.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants();
  Future<Either<Failure, List<FoodModel>>> getRecommendedFoods();
}
