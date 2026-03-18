import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, ProfileStatsModel>> getProfileStats();
}
