import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    
    final profileResult = await repository.getProfile();
    final statsResult = await repository.getProfileStats();

    profileResult.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) {
        statsResult.fold(
          (failure) => emit(ProfileError(failure.message)),
          (stats) => emit(ProfileSuccess(profile: profile, stats: stats)),
        );
      },
    );
  }
}
