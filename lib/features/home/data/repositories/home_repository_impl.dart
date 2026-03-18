import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/home_models.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants({int limit = 10, int offset = 0}) async {
    try {
      final restaurants = await remoteDataSource.getRestaurants(limit: limit, offset: offset);
      return Right(restaurants);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getRecommendedFoods({int limit = 10, int offset = 0}) async {
    try {
      final foods = await remoteDataSource.getRecommendedFoods(limit: limit, offset: offset);
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
