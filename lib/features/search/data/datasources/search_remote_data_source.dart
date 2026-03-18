import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../home/data/models/home_models.dart';

abstract class SearchRemoteDataSource {
  Future<List<RestaurantModel>> searchRestaurants(String query);
  Future<List<FoodModel>> searchFoods(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final SupabaseClient supabaseClient;

  SearchRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response = await supabaseClient
        .from('restaurants')
        .select()
        .ilike('name', '%$query%');

    return (response as List)
        .map((json) => RestaurantModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<FoodModel>> searchFoods(String query) async {
    final response = await supabaseClient
        .from('foods')
        .select('''
          *,
          restaurants(name),
          food_ingredients(ingredients(*)),
          food_sizes(*),
          food_addons(*)
        ''')
        .ilike('name', '%$query%');

    return (response as List)
        .map((json) => FoodModel.fromJson(json))
        .toList();
  }
}
