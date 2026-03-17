import '../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity? user;
  AuthSuccess([this.user]);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthPasswordVisibilityChanged extends AuthState {
  final bool isVisible;
  AuthPasswordVisibilityChanged(this.isVisible);
}

