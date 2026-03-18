import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';
import '../../domain/repositories/restaurant_details_repository.dart';
import '../datasources/restaurant_details_remote_data_source.dart';

class RestaurantDetailsRepositoryImpl implements RestaurantDetailsRepository {
  final RestaurantDetailsRemoteDataSource remoteDataSource;

  RestaurantDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<FoodModel>>> getRestaurantMenu(String restaurantId) async {
    try {
      final menu = await remoteDataSource.getRestaurantMenu(restaurantId);
      return Right(menu);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
