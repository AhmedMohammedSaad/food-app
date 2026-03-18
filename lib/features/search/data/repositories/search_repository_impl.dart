import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';
import '../datasources/search_remote_data_source.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<RestaurantModel>>> searchRestaurants(String query) async {
    try {
      final restaurants = await remoteDataSource.searchRestaurants(query);
      return Right(restaurants);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FoodModel>>> searchFoods(String query) async {
    try {
      final foods = await remoteDataSource.searchFoods(query);
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
