import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../home/data/models/home_models.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<FoodModel>> getFavoriteFoods(String userId);
  Future<List<RestaurantModel>> getFavoriteRestaurants(String userId);
  Future<void> addFoodToFavorites(String userId, String foodId);
  Future<void> removeFoodFromFavorites(String userId, String foodId);
  Future<void> addRestaurantToFavorites(String userId, String restaurantId);
  Future<void> removeRestaurantFromFavorites(String userId, String restaurantId);
  Future<bool> isFoodFavorite(String userId, String foodId);
  Future<bool> isRestaurantFavorite(String userId, String restaurantId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final SupabaseClient supabaseClient;

  FavoritesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<FoodModel>> getFavoriteFoods(String userId) async {
    final response = await supabaseClient
        .from('favorite_foods')
        .select('foods(*, restaurants(name))')
        .eq('user_id', userId);

    return (response as List)
        .map((json) => FoodModel.fromJson(json['foods']))
        .toList();
  }

  @override
  Future<List<RestaurantModel>> getFavoriteRestaurants(String userId) async {
    final response = await supabaseClient
        .from('favorite_restaurants')
        .select('restaurants(*)')
        .eq('user_id', userId);

    return (response as List)
        .map((json) => RestaurantModel.fromJson(json['restaurants']))
        .toList();
  }

  @override
  Future<void> addFoodToFavorites(String userId, String foodId) async {
    await supabaseClient.from('favorite_foods').insert({
      'user_id': userId,
      'food_id': foodId,
    });
  }

  @override
  Future<void> removeFoodFromFavorites(String userId, String foodId) async {
    await supabaseClient
        .from('favorite_foods')
        .delete()
        .match({'user_id': userId, 'food_id': foodId});
  }

  @override
  Future<void> addRestaurantToFavorites(String userId, String restaurantId) async {
    await supabaseClient.from('favorite_restaurants').insert({
      'user_id': userId,
      'restaurant_id': restaurantId,
    });
  }

  @override
  Future<void> removeRestaurantFromFavorites(String userId, String restaurantId) async {
    await supabaseClient
        .from('favorite_restaurants')
        .delete()
        .match({'user_id': userId, 'restaurant_id': restaurantId});
  }

  @override
  Future<bool> isFoodFavorite(String userId, String foodId) async {
    final response = await supabaseClient
        .from('favorite_foods')
        .select()
        .match({'user_id': userId, 'food_id': foodId})
        .maybeSingle();
    return response != null;
  }

  @override
  Future<bool> isRestaurantFavorite(String userId, String restaurantId) async {
    final response = await supabaseClient
        .from('favorite_restaurants')
        .select()
        .match({'user_id': userId, 'restaurant_id': restaurantId})
        .maybeSingle();
    return response != null;
  }
}
