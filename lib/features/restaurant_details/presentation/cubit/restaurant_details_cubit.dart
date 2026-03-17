import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/home_models.dart';

class RestaurantDetailsState {
  final String selectedCategory;
  final List<FoodModel> menuItems;

  const RestaurantDetailsState({
    required this.selectedCategory,
    required this.menuItems,
  });

  RestaurantDetailsState copyWith({
    String? selectedCategory,
    List<FoodModel>? menuItems,
  }) {
    return RestaurantDetailsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  RestaurantDetailsCubit()
      : super(const RestaurantDetailsState(
          selectedCategory: 'Popular',
          menuItems: [],
        ));

  void loadMenu(String restaurantId) {
    // Demo data for menu items with ingredients, sizes and add-ons
    final demoMenu = [
      const FoodModel(
        id: '1',
        name: 'Truffle Mushroom Pizza',
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAKE4aV0al5-RLW2ci54Nwopluo3cGe7walsHXnma-jUGDYvWk912evqHVo2scuBOM2J4LtHUgNBa6LRCtRhlrZuY3mcWrtSGv1LGFm89rsTMNQIMLdeV0cM3z-rj8XTVnuyq7D8i6PTDxjWWMfEdYq3URNJfAd8Hn6L5IlxhlfF6JmcP3TFgWjfQru6HDJcz6KqivT6CSsSYHRqAN7KnkjPO127tU1-svc0l9TLU8F43mJhmYuB1z6B5Mg0cb6BcIlwWTi5NcFRHdw',
        price: 14.99,
        description: 'White sauce base, forest mushrooms, mozzarella, and drizzle of premium truffle oil.',
        restaurantName: 'The Green Kitchen',
        ingredients: [
          IngredientModel(name: 'Mushroom', icon: 'mushroom'),
          IngredientModel(name: 'Cheese', icon: 'cheese'),
          IngredientModel(name: 'Truffle', icon: 'eco'),
          IngredientModel(name: 'Flour', icon: 'grain'),
        ],
        sizes: [
          SizeModel(id: 's1', name: 'Small', priceOffset: 0.0),
          SizeModel(id: 's2', name: 'Medium', priceOffset: 3.0),
          SizeModel(id: 's3', name: 'Large', priceOffset: 6.0),
        ],
        addOns: [
          AddOnModel(id: 'a1', name: 'Extra Cheese', price: 2.0),
          AddOnModel(id: 'a2', name: 'Extra Truffle Oil', price: 4.0),
          AddOnModel(id: 'a3', name: 'Garlic Crust', price: 1.5),
        ],
      ),
      const FoodModel(
        id: '2',
        name: 'Pesto Genovese Pasta',
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDY-IjP8asZDdOvdz6uNhiDxzizyIeKAtbTIfeGqBQ_eH-XaUWowGrpGr25Thx12RgdK7iFmjhkWTDYNxtHdO_EoeQf6pnhhVvyBl5VPnf2c09758cijsXkxOavIvlbSVFRQoSJjGk9i9xKMr0q1Dj-cCjIK2V8DPXul-7vXG1iz45Yb2U_dhzXggRxzAlRTI2sb4NpyqFXa5Pnt4a0dphTfDZAnCQ3ytGm47yZ3Sr9jNKFiK5_BDLeASPTqFnpcokDPC20vnwmElbq',
        price: 12.99,
        description: 'Fresh basil pesto, toasted pine nuts, and aged parmesan with handmade tagliatelle.',
        restaurantName: 'The Green Kitchen',
        ingredients: [
          IngredientModel(name: 'Basil', icon: 'eco'),
          IngredientModel(name: 'Pine Nuts', icon: 'eco'),
          IngredientModel(name: 'Cheese', icon: 'cheese'),
          IngredientModel(name: 'Pasta', icon: 'restaurant'),
        ],
        sizes: [
          SizeModel(id: 's1', name: 'Regular', priceOffset: 0.0),
          SizeModel(id: 's3', name: 'Family Size', priceOffset: 8.0),
        ],
        addOns: [
          AddOnModel(id: 'a4', name: 'Extra Pesto', price: 1.5),
          AddOnModel(id: 'a5', name: 'Chicken', price: 3.5),
        ],
      ),
      const FoodModel(
        id: '3',
        name: 'Burrata Garden Salad',
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAkmCkb-B5lZZdBhCtS5TsK8yJvVCy1domK4Ey20md6xpS2OosLRUqW_3TnfV-UUWjFcyCFH9TOOE32rQIZYY5J6CCOutIB1i-JFVN2aHlai6hOuHUET4FigjlG0RqdkYM_81Whj0x59tjxFaFuiMzDp_3JeppoMhXUxUKKNnjUWMYMtdtbQRL2wNX9XA0ndgvFSdZH90ANZ1zFYQc-0Zv8_mtTnxuB-8x5VULXG-T_89hLJ3j7BLPqJ59lcQsnktrmNL_JQgwko65n',
        price: 11.50,
        description: 'Creamy burrata, heirloom tomatoes, arugula, and balsamic reduction.',
        restaurantName: 'The Green Kitchen',
        ingredients: [
          IngredientModel(name: 'Tomato', icon: 'tomato'),
          IngredientModel(name: 'Arugula', icon: 'eco'),
          IngredientModel(name: 'Burrata', icon: 'cheese'),
        ],
        sizes: [
          SizeModel(id: 's1', name: 'Side', priceOffset: 0.0),
          SizeModel(id: 's2', name: 'Full', priceOffset: 4.5),
        ],
        addOns: [
          AddOnModel(id: 'a6', name: 'Extra Balsamic', price: 0.5),
          AddOnModel(id: 'a7', name: 'Breadsticks', price: 2.0),
        ],
      ),
      const FoodModel(
        id: '4',
        name: 'Margherita Classic',
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC0-CsOrc-NauSFzEcnBbC-HQWB8KE9K5lmP6K_TczmDqDJaD5wJkNMCxlpQ1Z1Svf8XOobXhqCX3PFv1NoN_SrNyopNEWSB1lXr7CCDdQmhaWJsnRFD5UEmaG1FUB-aKveFofPzolEadcan3U80AWI_nkiTHY-oysp6fbQnE2XWJJSVD6Eh6-fZYRABf13l2ovbzTNmIu_ODJy8rCsmsKNqA8kJUH_IOfxwq5TiKOJQPL9v472GZEAS335M2vBaI40Oq4JB8b4SENB',
        price: 13.00,
        description: 'San Marzano tomatoes, buffalo mozzarella, fresh basil, and extra virgin olive oil.',
        restaurantName: 'The Green Kitchen',
        ingredients: [
          IngredientModel(name: 'Tomato', icon: 'tomato'),
          IngredientModel(name: 'Basil', icon: 'eco'),
          IngredientModel(name: 'Cheese', icon: 'cheese'),
        ],
        sizes: [
          SizeModel(id: 's1', name: 'Small', priceOffset: 0.0),
          SizeModel(id: 's2', name: 'Medium', priceOffset: 3.0),
          SizeModel(id: 's3', name: 'Large', priceOffset: 6.0),
        ],
        addOns: [
          AddOnModel(id: 'a1', name: 'Extra Cheese', price: 2.0),
          AddOnModel(id: 'a8', name: 'Spicy Salami', price: 3.0),
        ],
      ),
    ];
    emit(state.copyWith(menuItems: demoMenu));
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
