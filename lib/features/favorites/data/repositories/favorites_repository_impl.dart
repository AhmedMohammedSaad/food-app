import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/data/models/home_models.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;
  final SupabaseClient supabaseClient;

  FavoritesRepositoryImpl(this.remoteDataSource, this.supabaseClient);

  String? get _userId => supabaseClient.auth.currentUser?.id;

  @override
  Future<Either<Failure, List<FoodModel>>> getFavoriteFoods() async {
    try {
      if (_userId == null) return Left(ServerFailure("User not authenticated"));
      final foods = await remoteDataSource.getFavoriteFoods(_userId!);
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantModel>>> getFavoriteRestaurants() async {
    try {
      if (_userId == null) return Left(ServerFailure("User not authenticated"));
      final restaurants = await remoteDataSource.getFavoriteRestaurants(_userId!);
      return Right(restaurants);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFoodToFavorites(String foodId) async {
    try {
      if (_userId == null) return Left(ServerFailure("User not authenticated"));
      await remoteDataSource.addFoodToFavorites(_userId!, foodId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFoodFromFavorites(String foodId) async {
    try {
      if (_userId == null) return Left(ServerFailure("User not authenticated"));
      await remoteDataSource.removeFoodFromFavorites(_userId!, foodId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addRestaurantToFavorites(String restaurantId) async {
    try {
      if (_userId == null) return Left(ServerFailure("User not authenticated"));
      await remoteDataSource.addRestaurantToFavorites(_userId!, restaurantId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeRestaurantFromFavorites(String restaurantId) async {
    try {
      if (_userId == null) return Left(ServerFailure("User not authenticated"));
      await remoteDataSource.removeRestaurantFromFavorites(_userId!, restaurantId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFoodFavorite(String foodId) async {
    try {
      if (_userId == null) return const Right(false);
      final isFav = await remoteDataSource.isFoodFavorite(_userId!, foodId);
      return Right(isFav);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isRestaurantFavorite(String restaurantId) async {
    try {
      if (_userId == null) return const Right(false);
      final isFav = await remoteDataSource.isRestaurantFavorite(_userId!, restaurantId);
      return Right(isFav);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
