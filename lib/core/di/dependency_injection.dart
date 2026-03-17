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
import '../../features/search/presentation/cubit/search_cubit.dart';
import '../../features/food_details/presentation/cubit/food_details_cubit.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';

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

void _initHome() {
  // Data sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()));

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt()));

  // Cubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}

void _initCart() {
  getIt.registerFactory<CartCubit>(() => CartCubit());
}

void _initSearch() {
  getIt.registerFactory<SearchCubit>(() => SearchCubit());
}

void _initFoodDetails() {
  getIt.registerFactory<FoodDetailsCubit>(() => FoodDetailsCubit());
}

void _initFavorites() {
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit());
}

