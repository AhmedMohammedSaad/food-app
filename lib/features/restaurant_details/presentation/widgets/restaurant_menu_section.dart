import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/restaurant_details_cubit.dart';
import 'menu_item_widget.dart';

class RestaurantMenuSection extends StatelessWidget {
  const RestaurantMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['Popular', 'Meals', 'Drinks', 'Desserts', 'Sides'];
    return MultiSliver(
      children: [
        SliverPersistentHeader(
          pinned: true,
          delegate: MenuCategoryDelegate(categories),
        ),
        BlocBuilder<RestaurantDetailsCubit, RestaurantDetailsState>(
          builder: (context, state) {
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return MenuItemWidget(food: state.menuItems[index]);
                }, childCount: state.menuItems.length),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MultiSliver extends StatelessWidget {
  final List<Widget> children;
  const MultiSliver({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: children);
  }
}

class MenuCategoryDelegate extends SliverPersistentHeaderDelegate {
  final List<String> categories;

  MenuCategoryDelegate(this.categories);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return BlocBuilder<RestaurantDetailsCubit, RestaurantDetailsState>(
      builder: (context, state) {
        return Container(
          color: AppColors.backgroundLight,
          height: 50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = state.selectedCategory == category;
              return GestureDetector(
                onTap: () {
                  context.read<RestaurantDetailsCubit>().selectCategory(
                    category,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 24.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: isSelected
                        ? AppTextStyle.font16SemiBoldCharcoal.copyWith(
                            color: AppColors.primary,
                          )
                        : AppTextStyle.font16RegularCharcoal.copyWith(
                            color: Colors.grey,
                          ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 50.h;

  @override
  double get minExtent => 50.h;

  @override
  bool shouldRebuild(covariant MenuCategoryDelegate oldDelegate) => true;
}
