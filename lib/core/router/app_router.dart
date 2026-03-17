import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/view/onboarding_view.dart';
import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/auth/presentation/view/forgot_password_view.dart';
import '../../features/auth/presentation/view/otp_view.dart';
import '../presentation/view/main_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/home/presentation/view/restaurants_view_all_view.dart';
import '../../features/home/presentation/view/foods_view_all_view.dart';
import '../../features/home/data/models/home_models.dart';
import '../../features/restaurant_details/presentation/view/restaurant_details_view.dart';
import '../../features/search/presentation/view/search_view.dart';
import '../../features/food_details/presentation/view/food_details_view.dart';
import '../../features/favorites/presentation/view/favorites_view.dart';
import '../../features/cart/presentation/view/cart_view.dart';
import '../../features/checkout/presentation/view/checkout_view.dart';
import '../../features/orders/presentation/view/order_tracking_view.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.otp:
        return MaterialPageRoute(builder: (_) => const OTPView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.restaurantsViewAll:
        final restaurants = settings.arguments as List<RestaurantModel>;
        return MaterialPageRoute(builder: (_) => RestaurantsViewAllView(restaurants: restaurants));
      case Routes.foodsViewAll:
        final foods = settings.arguments as List<FoodModel>;
        return MaterialPageRoute(builder: (_) => FoodsViewAllView(foods: foods));
      case Routes.restaurantDetails:
        final restaurant = settings.arguments as RestaurantModel;
        return MaterialPageRoute(
            builder: (_) => RestaurantDetailsView(restaurant: restaurant));
      case Routes.foodDetails:
        final food = settings.arguments as FoodModel;
        return MaterialPageRoute(
            builder: (_) => FoodDetailsView(food: food));
      case Routes.checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutView());
      case Routes.orderTracking:
        return MaterialPageRoute(builder: (_) => const OrderTrackingView());
      case Routes.cart:
        return MaterialPageRoute(builder: (_) => const CartView());
      case Routes.search:
        return MaterialPageRoute(builder: (_) => const SearchView());
      case Routes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesView());
      default:
        return null;
    }
  }
}
