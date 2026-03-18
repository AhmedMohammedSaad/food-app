import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/api_consumer.dart';
import '../data/dio_consumer.dart';
import '../router/app_router.dart';

import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/restaurants_view_all_cubit.dart';
import '../../features/home/presentation/cubit/foods_view_all_cubit.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';

import '../../features/restaurant_details/data/datasources/restaurant_details_remote_data_source.dart';
import '../../features/restaurant_details/presentation/cubit/restaurant_details_cubit.dart';

import '../../features/food_details/presentation/cubit/food_details_cubit.dart';

import '../../features/search/data/datasources/search_remote_data_source.dart';
import '../../features/search/data/repositories/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';

import '../../features/cart/data/datasources/cart_remote_data_source.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';

import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';

import '../../features/favorites/presentation/cubit/favorites_cubit.dart';

import '../../features/orders/data/datasources/order_remote_data_source.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/presentation/cubit/order_cubit.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  // Supabase
  getIt.registerLazySingleton(() => Supabase.instance.client);

  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Networking
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: getIt()));

  // Features
  _initOnboarding();
  _initAuth();
  _initHome();
  _initSearch();
  _initFoodDetails();
  _initCart();
  _initFavorites();
  _initProfile();
  _initRestaurantDetails();
  _initOrders();
}

void _initOnboarding() {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}

void _initAuth() {
  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));

  // Cubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(
        signInUseCase: getIt(),
        signUpUseCase: getIt(),
        signOutUseCase: getIt(),
        getCurrentUserUseCase: getIt(),
      ));
}

void _initProfile() {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerFactory(() => ProfileCubit(getIt()));
}

void _initHome() {
  // Data sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()));

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt()));

  // Cubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerFactory<RestaurantsViewAllCubit>(() => RestaurantsViewAllCubit(getIt()));
  getIt.registerFactory<FoodsViewAllCubit>(() => FoodsViewAllCubit(getIt()));
}

void _initCart() {
  getIt.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<CartCubit>(() => CartCubit(getIt()));
}

void _initSearch() {
  // Data sources
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt()),
  );

  // Cubit
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
}

void _initFoodDetails() {
  getIt.registerFactory<FoodDetailsCubit>(() => FoodDetailsCubit(getIt()));
}

void _initFavorites() {
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit());
}

void _initRestaurantDetails() {
  getIt.registerLazySingleton<RestaurantDetailsRemoteDataSource>(
      () => RestaurantDetailsRemoteDataSourceImpl(getIt()));
  getIt.registerFactory<RestaurantDetailsCubit>(
      () => RestaurantDetailsCubit(getIt()));
}

void _initOrders() {
  getIt.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerFactory(() => OrderCubit(getIt()));
}

