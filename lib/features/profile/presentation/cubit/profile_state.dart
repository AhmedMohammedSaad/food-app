import '../../data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profile;
  final ProfileStatsModel stats;

  ProfileSuccess({required this.profile, required this.stats});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
