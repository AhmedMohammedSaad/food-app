import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/home_models.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'restaurant_item.dart';

class HomePopularRestaurantsSection extends StatefulWidget {
  final List<RestaurantModel> restaurants;
  final VoidCallback onViewAll;

  const HomePopularRestaurantsSection({
    super.key,
    required this.restaurants,
    required this.onViewAll,
  });

  @override
  State<HomePopularRestaurantsSection> createState() => _HomePopularRestaurantsSectionState();
}

class _HomePopularRestaurantsSectionState extends State<HomePopularRestaurantsSection> {
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
      context.read<HomeCubit>().loadMoreRestaurants();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular Restaurants", style: AppTextStyle.font18SemiBoldCharcoal),
              GestureDetector(
                onTap: widget.onViewAll,
                child: Text("View all", style: AppTextStyle.font14BoldPrimary),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              ...widget.restaurants.map((restaurant) => RestaurantItem(restaurant: restaurant)),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeSuccess && state.isMoreRestaurantsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
