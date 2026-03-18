class CategoryModel {
  final String id;
  final String name;
  final String icon;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon_emoji'] ?? '🍔',
    );
  }
}

class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final String distance;
  final List<String> tags;
  final bool hasFreeDelivery;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.distance,
    required this.tags,
    this.hasFreeDelivery = false,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      deliveryTime: '${json['min_delivery_time']}-${json['max_delivery_time']} min',
      distance: '1.0 km', // Distance might need calculation or extra field
      tags: List<String>.from(json['tags'] ?? []),
      hasFreeDelivery: json['has_free_delivery'] ?? false,
    );
  }
}

class IngredientModel {
  final String name;
  final String icon;

  const IngredientModel({required this.name, required this.icon});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    // If coming from food_ingredients join
    final ingredient = json['ingredients'] ?? json;
    return IngredientModel(
      name: ingredient['name'] as String,
      icon: ingredient['icon_name'] ?? 'eco',
    );
  }
}

class SizeModel {
  final String id;
  final String name;
  final double priceOffset;

  const SizeModel({
    required this.id,
    required this.name,
    this.priceOffset = 0.0,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      priceOffset: (json['price_offset'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class AddOnModel {
  final String id;
  final String name;
  final double price;

  const AddOnModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddOnModel.fromJson(Map<String, dynamic> json) {
    return AddOnModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class FoodModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final String restaurantId;
  final String restaurantName;
  final String menuCategory;
  final double rating;
  final List<IngredientModel> ingredients;
  final List<SizeModel> sizes;
  final List<AddOnModel> addOns;

  const FoodModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.restaurantId,
    required this.restaurantName,
    required this.menuCategory,
    this.rating = 4.5,
    this.ingredients = const [],
    this.sizes = const [],
    this.addOns = const [],
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] ?? '',
      price: (json['base_price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      restaurantId: json['restaurant_id'] as String? ?? '',
      restaurantName: json['restaurants']?['name'] ?? '',
      menuCategory: json['menu_category'] ?? 'Main Dishes',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      ingredients: (json['food_ingredients'] as List?)
              ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      sizes: (json['food_sizes'] as List?)
              ?.map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      addOns: (json['food_addons'] as List?)
              ?.map((e) => AddOnModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
