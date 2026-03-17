import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSkeleton(),
              _buildSearchSkeleton(),
              _buildBannerSkeleton(),
              _buildCategoriesSkeleton(),
              _buildRestaurantsSkeleton(),
              _buildRecommendedSkeleton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSkeleton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ShimmerBox(width: 150, height: 20),
          ShimmerBox(width: 40, height: 40, borderRadius: 20),
        ],
      ),
    );
  }

  Widget _buildSearchSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ShimmerBox(width: double.infinity, height: 50, borderRadius: 12),
    );
  }

  Widget _buildBannerSkeleton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: ShimmerBox(width: double.infinity, height: 160, borderRadius: 16),
    );
  }

  Widget _buildCategoriesSkeleton() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(width: 100, height: 20),
              ShimmerBox(width: 60, height: 15),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.w),
            itemCount: 5,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Column(
                children: [
                  ShimmerBox(width: 60, height: 60, borderRadius: 30),
                  SizedBox(height: 8.h),
                  const ShimmerBox(width: 50, height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantsSkeleton() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(width: 140, height: 20),
              ShimmerBox(width: 60, height: 15),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.w),
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 280, height: 150, borderRadius: 16),
                  SizedBox(height: 8.h),
                  const ShimmerBox(width: 200, height: 15),
                  SizedBox(height: 6.h),
                  const ShimmerBox(width: 150, height: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSkeleton() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(width: 120, height: 20),
              ShimmerBox(width: 60, height: 15),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    ShimmerBox(width: 80, height: 80, borderRadius: 12),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerBox(width: 180, height: 15),
                          SizedBox(height: 8.h),
                          ShimmerBox(width: 120, height: 12),
                          SizedBox(height: 8.h),
                          ShimmerBox(width: 60, height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
