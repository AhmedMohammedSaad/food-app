import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String userId, String email);
  Future<ProfileStatsModel> getProfileStats(String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ProfileModel> getProfile(String userId, String email) async {
    final response = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    
    return ProfileModel.fromJson(response, email);
  }

  @override
  Future<ProfileStatsModel> getProfileStats(String userId) async {
    final ordersResponse = await supabaseClient
        .from('orders')
        .select('id')
        .eq('user_id', userId);
    
    final favFoodsResponse = await supabaseClient
        .from('favorite_foods')
        .select('food_id')
        .eq('user_id', userId);

    final favRestaurantsResponse = await supabaseClient
        .from('favorite_restaurants')
        .select('restaurant_id')
        .eq('user_id', userId);

    return ProfileStatsModel(
      ordersCount: (ordersResponse as List).length,
      reviewsCount: 0,
      favoritesCount: (favFoodsResponse as List).length + (favRestaurantsResponse as List).length,
    );
  }
}
