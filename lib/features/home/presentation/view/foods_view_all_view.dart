import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/home_models.dart';
import '../cubit/foods_view_all_cubit.dart';
import '../cubit/foods_view_all_state.dart';

class FoodsViewAllView extends StatefulWidget {
  final List<FoodModel> foods;

  const FoodsViewAllView({super.key, required this.foods});

  @override
  State<FoodsViewAllView> createState() => _FoodsViewAllViewState();
}

class _FoodsViewAllViewState extends State<FoodsViewAllView> {
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
      context.read<FoodsViewAllCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FoodsViewAllCubit>()..getInitialFoods(widget.foods),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Recommended For You",
            style: AppTextStyle.font18SemiBoldCharcoal,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<FoodsViewAllCubit, FoodsViewAllState>(
          builder: (context, state) {
            if (state is FoodsViewAllSuccess) {
              return GridView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.r),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: state.foods.length + (state.hasMore ? 2 : 0), // Add items for loading
                itemBuilder: (context, index) {
                  if (index >= state.foods.length) {
                    if (state.isMoreLoading && index == state.foods.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  }
                  final food = state.foods[index];
                  return _buildFoodCard(food);
                },
              );
            } else if (state is FoodsViewAllError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildFoodCard(FoodModel food) {
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
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Image.network(
                food.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: AppTextStyle.font14SemiBoldCharcoal,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  food.restaurantName,
                  style: AppTextStyle.font12MediumSlate300,
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${food.price}",
                      style: AppTextStyle.font14BoldPrimary,
                    ),
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 14.sp,
                      ),
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
