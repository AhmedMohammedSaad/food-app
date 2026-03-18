import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../features/cart/data/models/cart_item_model.dart';
import 'package:test_food_app/features/orders/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders(String userId);
  Stream<List<OrderModel>> getOrdersStream(String userId);
  Future<OrderModel> placeOrder({
    required String userId,
    required String restaurantId,
    required String? addressId,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double totalAmount,
    required String paymentMethod,
    required List<CartItemModel> cartItems,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final SupabaseClient supabaseClient;

  OrderRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<OrderModel>> getOrders(String userId) async {
    final response = await supabaseClient
        .from('orders')
        .select('''
          *,
          restaurants(name, image_url),
          order_items(
            *,
            order_item_addons(*)
          )
        ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((json) {
      print('Order JSON: $json');
      return OrderModel.fromJson(json);
    }).toList();
  }

  @override
  Stream<List<OrderModel>> getOrdersStream(String userId) {
    return supabaseClient
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .asyncMap((event) => getOrders(userId));
  }

  @override
  Future<OrderModel> placeOrder({
    required String userId,
    required String restaurantId,
    required String? addressId,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double totalAmount,
    required String paymentMethod,
    required List<CartItemModel> cartItems,
  }) async {
    // 1. Create the order
    final orderResponse = await supabaseClient.from('orders').insert({
      'user_id': userId,
      'restaurant_id': restaurantId,
      'address_id': addressId,
      'status': 'received',
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'tax': tax,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
    }).select().single();

    final orderId = orderResponse['id'];

    // 2. Create order items and their addons
    for (final item in cartItems) {
      final itemResponse = await supabaseClient.from('order_items').insert({
        'order_id': orderId,
        'food_id': item.food.id,
        'food_name': item.food.name,
        'quantity': item.quantity,
        'size_name': item.selectedSize?.name,
        'unit_price': item.food.price + (item.selectedSize?.priceOffset ?? 0),
        'total_price': item.totalPrice,
      }).select().single();

      final orderItemId = itemResponse['id'];

      if (item.selectedAddOns.isNotEmpty) {
        final addonsToInsert = item.selectedAddOns.map((addon) => {
          'order_item_id': orderItemId,
          'addon_name': addon.name,
          'price': addon.price,
        }).toList();

        await supabaseClient.from('order_item_addons').insert(addonsToInsert);
      }
    }

    // 3. Clear cart (optional here or in Cubit, usually better in Cubit if we want to handle failures)
    // We'll return the created order (re-fetching to get the full joined data if needed, 
    // but for now the basic orderResponse is enough or we fetch it again).
    return getOrderById(orderId);
  }

  Future<OrderModel> getOrderById(String orderId) async {
    final response = await supabaseClient
        .from('orders')
        .select('''
          *,
          restaurants(name, image_url),
          order_items(
            *,
            order_item_addons(*)
          )
        ''')
        .eq('id', orderId)
        .single();

    return OrderModel.fromJson(response);
  }
}
