import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/data/models/home_models.dart';

class RestaurantDetailsAppBarSection extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailsAppBarSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240.h,
      pinned: true,
      backgroundColor: AppColors.white,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: CircleAvatar(
          backgroundColor: AppColors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.charcoal),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: AppColors.white,
          child: IconButton(
            icon: const Icon(Icons.share, color: AppColors.charcoal),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 8.w),
        CircleAvatar(
          backgroundColor: AppColors.white,
          child: IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.primary),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 16.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(restaurant.imageUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
