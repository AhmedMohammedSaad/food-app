import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailPassword(String email, String password);
  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password,
    String fullName,
  );
  Future<void> signOut();
  UserModel? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerFailure('Login failed, no user returned');
      }

      // Fetch profile data
      final profileResponse = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', response.user!.id)
          .single();

      return UserModel.fromJson(profileResponse);
    } on AuthException catch (e) {
      log(e.toString());
      throw ServerFailure(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user == null) {
        throw const ServerFailure('Signup failed, no user returned');
      }

      final userId = response.user!.id;

      // Ensure profile exists or insert it explicitly
      await supabaseClient
          .from('profiles')
          .upsert({'id': userId, 'full_name': fullName})
          .select()
          .single();

      return UserModel(
        id: userId,
        email: response.user!.email ?? email,
        fullName: fullName,
      );
    } on AuthException catch (e) {
      log(e.toString());
      throw ServerFailure(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  UserModel? getCurrentUser() {
    final session = supabaseClient.auth.currentSession;
    if (session != null) {
      return UserModel(
        id: session.user.id,
        email: session.user.email!,
        fullName: session.user.userMetadata?['full_name'] ?? 'User',
      );
    }
    return null;
  }
}
