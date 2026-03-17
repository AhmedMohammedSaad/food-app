import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';
import '../../../home/data/models/home_models.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCartData() {
    emit(CartLoading());
    // Mock data based on Figma
    final mockItems = [
      CartItemModel(
        food: const FoodModel(
          id: '1',
          name: 'Margherita Pizza',
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=800',
          price: 14.99,
          description: '',
          restaurantName: "Luigi's Pizzeria",
        ),
        quantity: 1,
      ),
      CartItemModel(
        food: const FoodModel(
          id: '2',
          name: 'Caesar Salad',
          imageUrl:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=800',
          price: 8.99,
          description: '',
          restaurantName: 'Green Garden',
        ),
        quantity: 1,
      ),
      CartItemModel(
        food: const FoodModel(
          id: '3',
          name: 'Chocolate Brownie',
          imageUrl:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=800',
          price: 5.99,
          description: '',
          restaurantName: 'Dessert Heaven',
        ),
        quantity: 1,
      ),
    ];
    emit(CartSuccess(items: mockItems));
  }

  void updateQuantity(String foodId, int delta) {
    if (state is CartSuccess) {
      final currentState = state as CartSuccess;
      final updatedItems = currentState.items.map((item) {
        if (item.food.id == foodId) {
          final newQuantity = item.quantity + delta;
          if (newQuantity > 0) {
            return item.copyWith(quantity: newQuantity);
          }
        }
        return item;
      }).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  void removeItem(String foodId) {
    if (state is CartSuccess) {
      final currentState = state as CartSuccess;
      final updatedItems = currentState.items
          .where((item) => item.food.id != foodId)
          .toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }
}
