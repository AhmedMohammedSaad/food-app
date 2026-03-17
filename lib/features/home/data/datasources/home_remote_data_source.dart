import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/home_models.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<RestaurantModel>> getRestaurants();
  Future<List<FoodModel>> getRecommendedFoods();
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
  Future<List<RestaurantModel>> getRestaurants() async {
    final response = await supabaseClient
        .from('restaurants')
        .select();
    
    return (response as List)
        .map((json) => RestaurantModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<FoodModel>> getRecommendedFoods() async {
    // Fetching foods with joins for ingredients, sizes, and addons
    final response = await supabaseClient
        .from('foods')
        .select('''
          *,
          restaurants(name),
          food_ingredients(ingredients(*)),
          food_sizes(*),
          food_addons(*)
        ''');
    
    return (response as List)
        .map((json) => FoodModel.fromJson(json))
        .toList();
  }
}
