import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_model.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final SupabaseClient supabaseClient;

  ProfileRepositoryImpl(this.remoteDataSource, this.supabaseClient);

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null) return const Left(ServerFailure('User not logged in'));
      
      final profile = await remoteDataSource.getProfile(user.id, user.email ?? '');
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileStatsModel>> getProfileStats() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null) return const Left(ServerFailure('User not logged in'));
      
      final stats = await remoteDataSource.getProfileStats(user.id);
      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
