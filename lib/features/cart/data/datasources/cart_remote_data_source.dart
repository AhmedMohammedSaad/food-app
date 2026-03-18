import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../home/data/models/home_models.dart';
import '../models/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems(String userId);
  Stream<List<CartItemModel>> getCartItemsStream(String userId);
  Future<void> addToCart({
    required FoodModel food,
    required SizeModel? size,
    required List<AddOnModel> addOns,
    required int quantity,
  });
  Future<void> updateQuantity(String cartItemId, int quantity);
  Future<void> removeItem(String cartItemId);
  Future<void> clearCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final SupabaseClient supabaseClient;

  CartRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<CartItemModel>> getCartItems(String userId) async {
    final response = await supabaseClient
        .from('cart_items')
        .select('''
          id,
          quantity,
          foods (*),
          food_sizes (*),
          cart_item_addons (
            food_addons (*)
          )
        ''')
        .eq('user_id', userId)
        .order('created_at');

    return (response as List).map((json) => CartItemModel.fromJson(json)).toList();
  }

  @override
  Stream<List<CartItemModel>> getCartItemsStream(String userId) {
    return supabaseClient
        .from('cart_items')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .asyncMap((event) => getCartItems(userId));
  }

  @override
  Future<void> addToCart({
    required FoodModel food,
    required SizeModel? size,
    required List<AddOnModel> addOns,
    required int quantity,
  }) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    // Insert cart item
    final cartItemResponse = await supabaseClient.from('cart_items').insert({
      'user_id': userId,
      'food_id': food.id,
      'size_id': size?.id,
      'quantity': quantity,
    }).select().single();

    final cartItemId = cartItemResponse['id'];

    // Insert addons if any
    if (addOns.isNotEmpty) {
      final addonData = addOns.map((addon) => {
        'cart_item_id': cartItemId,
        'addon_id': addon.id,
      }).toList();
      
      await supabaseClient.from('cart_item_addons').insert(addonData);
    }
  }

  @override
  Future<void> updateQuantity(String cartItemId, int quantity) async {
    await supabaseClient
        .from('cart_items')
        .update({'quantity': quantity})
        .eq('id', cartItemId);
  }

  @override
  Future<void> removeItem(String cartItemId) async {
    await supabaseClient.from('cart_items').delete().eq('id', cartItemId);
  }

  @override
  Future<void> clearCart(String userId) async {
    await supabaseClient.from('cart_items').delete().eq('user_id', userId);
  }
}
