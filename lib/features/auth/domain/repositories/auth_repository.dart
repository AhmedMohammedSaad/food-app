import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailPassword(
      String email, String password);
      
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword(
      String email, String password, String fullName);
      
  Future<Either<Failure, void>> signOut();
  
  Either<Failure, UserEntity?> getCurrentUser();
}
