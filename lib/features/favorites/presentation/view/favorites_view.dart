import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/favorites_cubit.dart';
import '../widgets/favorite_foods_section.dart';
import '../widgets/favorite_restaurants_section.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavoritesCubit>()..getFavorites(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            title: Text(
              "Favorites",
              style: AppTextStyle.font18BoldSlate900,
            ),
            centerTitle: true,
            bottom: TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.slate300,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3.h,
              labelStyle: AppTextStyle.font14MediumSlate900,
              unselectedLabelStyle: AppTextStyle.font14MediumSlate700,
              tabs: const [
                Tab(text: "Foods"),
                Tab(text: "Restaurants"),
              ],
            ),
          ),
          body: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FavoritesSuccess) {
                return TabBarView(
                  children: [
                    FavoriteFoodsSection(foods: state.favoriteFoods),
                    FavoriteRestaurantsSection(
                      restaurants: state.favoriteRestaurants,
                    ),
                  ],
                );
              } else if (state is FavoritesFailure) {
                return Center(child: Text(state.errorMessage));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
