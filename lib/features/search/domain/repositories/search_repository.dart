import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<RestaurantModel>>> searchRestaurants(String query);
  Future<Either<Failure, List<FoodModel>>> searchFoods(String query);
}
