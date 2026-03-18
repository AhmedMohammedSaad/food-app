import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_food_app/features/home/presentation/widgets/home_recommended_section.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/router/routes.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_categories_section.dart';
import '../widgets/home_filter_bottom_sheet.dart';
import '../widgets/home_header_section.dart';
import '../widgets/home_loading_skeleton.dart';
import '../widgets/home_popular_restaurants_section.dart';
import '../widgets/home_promo_banner_section.dart';
import '../widgets/home_search_bar_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeCubit>().loadMoreRecommendedFoods();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeLoadingSkeleton();
          } else if (state is HomeSuccess) {
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeCubit>().getHomeData();
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const HomeHeaderSection(),
                      HomeSearchBarSection(
                        initialValue: state.searchQuery,
                        onSearchChanged: (query) =>
                            context.read<HomeCubit>().search(query),
                        onFilterTapped: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => BlocProvider.value(
                              value: context.read<HomeCubit>(),
                              child: const HomeFilterBottomSheet(),
                            ),
                          );
                        },
                      ),
                      const HomePromoBannerSection(),
                      HomeCategoriesSection(
                        categories: state.categories,
                        selectedCategoryId: state.selectedCategoryId,
                        onCategorySelected: (id) =>
                            context.read<HomeCubit>().filterByCategory(id),
                      ),
                      HomePopularRestaurantsSection(
                        restaurants: state.restaurants,
                        onViewAll: () {
                          Navigator.pushNamed(
                            context,
                            Routes.restaurantsViewAll,
                            arguments: state.restaurants,
                          );
                        },
                      ),
                      HomeRecommendedSection(
                        foods: state.recommendedFoods,
                        onViewAll: () {
                          Navigator.pushNamed(
                            context,
                            Routes.foodsViewAll,
                            arguments: state.recommendedFoods,
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
