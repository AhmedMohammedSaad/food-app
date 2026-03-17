import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  // Using static demo data for now, similar to HomeCubit
  final List<RestaurantModel> _allRestaurants = [
    const RestaurantModel(
      id: '1',
      name: 'The Golden Grill',
      imageUrl: 'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=800',
      rating: 4.8,
      deliveryTime: '15-25 min',
      distance: '1.2 km',
      tags: ['Burgers', 'American'],
      hasFreeDelivery: true,
    ),
    const RestaurantModel(
      id: '102',
      name: 'Pizzeria Napoli',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=800',
      rating: 4.6,
      deliveryTime: '20-30 min',
      distance: '0.8 km',
      tags: ['Italian', 'Pizza'],
      hasFreeDelivery: false,
    ),
    const RestaurantModel(
      id: '2',
      name: 'Sushi Master',
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=800',
      rating: 4.9,
      deliveryTime: '25-40 min',
      distance: '2.5 km',
      tags: ['Japanese', 'Sushi'],
      hasFreeDelivery: true,
    ),
    const RestaurantModel(
      id: '104',
      name: 'Veggie Delight',
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=800',
      rating: 4.7,
      deliveryTime: '15-20 min',
      distance: '1.5 km',
      tags: ['Healthy', 'Salads'],
      hasFreeDelivery: true,
    ),
  ];

  final List<FoodModel> _allFoods = [
    const FoodModel(
      id: '1',
      name: 'Classic Beef Burger',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=800',
      price: 12.50,
      description: 'Juicy beef patty with cheddar cheese and special sauce.',
      restaurantName: 'The Golden Grill',
      ingredients: [
        IngredientModel(name: 'Beef', icon: 'meat'),
        IngredientModel(name: 'Cheese', icon: 'cheese'),
        IngredientModel(name: 'Tomato', icon: 'tomato'),
      ],
      sizes: [
        SizeModel(id: 's1', name: 'Single', priceOffset: 0.0),
        SizeModel(id: 's2', name: 'Double', priceOffset: 4.0),
      ],
    ),
    const FoodModel(
      id: '2',
      name: 'Salmon Avocado Bowl',
      imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=800',
      price: 15.00,
      description: 'Fresh Atlantic salmon with creamy avocado and quinoa.',
      restaurantName: 'Veggie Delight',
      ingredients: [
        IngredientModel(name: 'Salmon', icon: 'restaurant'),
        IngredientModel(name: 'Avocado', icon: 'eco'),
      ],
      sizes: [
        SizeModel(id: 's1', name: 'Regular', priceOffset: 0.0),
        SizeModel(id: 's2', name: 'Large', priceOffset: 5.0),
      ],
    ),
    const FoodModel(
      id: '103',
      name: 'Pepperoni Paradise',
      imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=800',
      price: 14.20,
      description: 'Loaded with spicy pepperoni and gooey mozzarella.',
      restaurantName: 'Pizzeria Napoli',
      ingredients: [
        IngredientModel(name: 'Pepperoni', icon: 'meat'),
        IngredientModel(name: 'Cheese', icon: 'cheese'),
      ],
      sizes: [
        SizeModel(id: 's1', name: 'Small', priceOffset: 0.0),
        SizeModel(id: 's2', name: 'Medium', priceOffset: 3.0),
        SizeModel(id: 's3', name: 'Large', priceOffset: 6.0),
      ],
    ),
  ];

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final q = query.toLowerCase();

    final filteredRestaurants = _allRestaurants.where((r) {
      return r.name.toLowerCase().contains(q) ||
          r.tags.any((tag) => tag.toLowerCase().contains(q));
    }).toList();

    final filteredFoods = _allFoods.where((f) {
      return f.name.toLowerCase().contains(q) ||
          f.description.toLowerCase().contains(q);
    }).toList();

    emit(SearchSuccess(
      restaurants: filteredRestaurants,
      foods: filteredFoods,
      query: query,
    ));
  }
}
