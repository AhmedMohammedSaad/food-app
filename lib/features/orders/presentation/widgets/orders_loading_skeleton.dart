import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class OrdersLoadingSkeleton extends StatelessWidget {
  const OrdersLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                ShimmerBox(
                  width: 60.r,
                  height: 60.r,
                  borderRadius: 12.r,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 120.w, height: 16.h),
                      SizedBox(height: 8.h),
                      ShimmerBox(width: 80.w, height: 14.h),
                      SizedBox(height: 8.h),
                      ShimmerBox(width: 60.w, height: 20.h, borderRadius: 8.r),
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
