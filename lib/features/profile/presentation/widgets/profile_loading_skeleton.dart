import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class ProfileLoadingSkeleton extends StatelessWidget {
  const ProfileLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          AppShimmer(
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  ShimmerBox(
                    width: 70.r,
                    height: 70.r,
                    borderRadius: 35.r,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 150.w, height: 18.h),
                        SizedBox(height: 8.h),
                        ShimmerBox(width: 180.w, height: 14.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return AppShimmer(
                child: Row(
                  children: [
                    ShimmerBox(width: 40.r, height: 40.r, borderRadius: 20.r),
                    SizedBox(width: 16.w),
                    ShimmerBox(width: 120.w, height: 16.h),
                    const Spacer(),
                    ShimmerBox(width: 24.r, height: 24.r, borderRadius: 12.r),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
