import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/home_models.dart';
import '../cubit/restaurants_view_all_cubit.dart';
import '../cubit/restaurants_view_all_state.dart';

class RestaurantsViewAllView extends StatefulWidget {
  final List<RestaurantModel> restaurants;

  const RestaurantsViewAllView({super.key, required this.restaurants});

  @override
  State<RestaurantsViewAllView> createState() => _RestaurantsViewAllViewState();
}

class _RestaurantsViewAllViewState extends State<RestaurantsViewAllView> {
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
      context.read<RestaurantsViewAllCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RestaurantsViewAllCubit>()..getInitialRestaurants(widget.restaurants),
      child: Scaffold(
        appBar: AppBar(
              title: Text(
                "Popular Restaurants",
                style: AppTextStyle.font18SemiBoldCharcoal,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: BlocBuilder<RestaurantsViewAllCubit, RestaurantsViewAllState>(
              builder: (context, state) {
                if (state is RestaurantsViewAllSuccess) {
                  return ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.r),
                    itemCount: state.restaurants.length + 1,
                    separatorBuilder: (context, index) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      if (index == state.restaurants.length) {
                        return state.isMoreLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox.shrink();
                      }
                      return _buildRestaurantCard(state.restaurants[index]);
                    },
                  );
                } else if (state is RestaurantsViewAllError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
      ),
    );
  }

  Widget _buildRestaurantCard(RestaurantModel restaurant) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Image.network(
              restaurant.imageUrl,
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.name,
                      style: AppTextStyle.font16SemiBoldCharcoal,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          restaurant.rating.toString(),
                          style: AppTextStyle.font12MediumSlate300,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  restaurant.tags.join(" • "),
                  style: AppTextStyle.font12MediumSlate300,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      restaurant.deliveryTime,
                      style: AppTextStyle.font12MediumSlate300,
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.delivery_dining,
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Free Delivery",
                      style: AppTextStyle.font12MediumSlate300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
