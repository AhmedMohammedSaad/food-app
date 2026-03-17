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
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants() async {
    try {
      final restaurants = await remoteDataSource.getRestaurants();
      return Right(restaurants);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getRecommendedFoods() async {
    try {
      final foods = await remoteDataSource.getRecommendedFoods();
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
