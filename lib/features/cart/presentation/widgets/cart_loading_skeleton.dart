import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class CartLoadingSkeleton extends StatelessWidget {
  const CartLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                ShimmerBox(
                  width: 80.r,
                  height: 80.r,
                  borderRadius: 12.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 120.w, height: 16.h),
                      SizedBox(height: 8.h),
                      ShimmerBox(width: 100.w, height: 14.h),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerBox(width: 60.w, height: 16.h),
                          Row(
                            children: [
                              ShimmerBox(width: 24.r, height: 24.r, borderRadius: 12.r),
                              SizedBox(width: 12.w),
                              ShimmerBox(width: 20.w, height: 14.h),
                              SizedBox(width: 12.w),
                              ShimmerBox(width: 24.r, height: 24.r, borderRadius: 12.r),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
