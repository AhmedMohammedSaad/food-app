import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/home_models.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<RestaurantModel>> getRestaurants({int limit = 10, int offset = 0});
  Future<List<FoodModel>> getRecommendedFoods({int limit = 10, int offset = 0});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supabaseClient;

  HomeRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await supabaseClient
        .from('categories')
        .select()
        .order('name');
    
    return (response as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<RestaurantModel>> getRestaurants({int limit = 10, int offset = 0}) async {
    final response = await supabaseClient
        .from('restaurants')
        .select()
        .range(offset, offset + limit - 1);
    
    return (response as List)
        .map((json) => RestaurantModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<FoodModel>> getRecommendedFoods({int limit = 10, int offset = 0}) async {
    // Fetching foods with joins for ingredients, sizes, and addons
    final response = await supabaseClient
        .from('foods')
        .select('''
          *,
          restaurants(name),
          food_ingredients(ingredients(*)),
          food_sizes(*),
          food_addons(*)
        ''')
        .range(offset, offset + limit - 1);
    
    return (response as List)
        .map((json) => FoodModel.fromJson(json))
        .toList();
  }
}
