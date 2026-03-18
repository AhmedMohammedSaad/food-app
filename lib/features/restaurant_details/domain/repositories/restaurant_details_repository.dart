import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';

abstract class RestaurantDetailsRepository {
  Future<Either<Failure, List<FoodModel>>> getRestaurantMenu(String restaurantId);
}
