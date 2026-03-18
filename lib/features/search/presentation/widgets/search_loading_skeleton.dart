import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class SearchLoadingSkeleton extends StatelessWidget {
  const SearchLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20.r),
      itemCount: 6,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Row(
            children: [
              ShimmerBox(
                width: 80.r,
                height: 80.r,
                borderRadius: 12.r,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 150.w, height: 16.h),
                    SizedBox(height: 8.h),
                    ShimmerBox(width: 100.w, height: 14.h),
                    SizedBox(height: 8.h),
                    ShimmerBox(width: 60.w, height: 14.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
