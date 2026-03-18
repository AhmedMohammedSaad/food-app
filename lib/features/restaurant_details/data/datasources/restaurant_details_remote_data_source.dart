import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../home/data/models/home_models.dart';

abstract class RestaurantDetailsRemoteDataSource {
  Future<List<FoodModel>> getRestaurantMenu(String restaurantId);
}

class RestaurantDetailsRemoteDataSourceImpl implements RestaurantDetailsRemoteDataSource {
  final SupabaseClient supabaseClient;

  RestaurantDetailsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<FoodModel>> getRestaurantMenu(String restaurantId) async {
    final response = await supabaseClient
        .from('foods')
        .select('''
          *,
          restaurants(name),
          food_ingredients(ingredients(*)),
          food_sizes(*),
          food_addons(*)
        ''')
        .eq('restaurant_id', restaurantId);
    
    return (response as List)
        .map((json) => FoodModel.fromJson(json))
        .toList();
  }
}
