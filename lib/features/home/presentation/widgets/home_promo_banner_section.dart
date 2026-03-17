import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class HomePromoBannerSection extends StatelessWidget {
  const HomePromoBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        height: 160.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFFE65100)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "30% OFF",
                        style: AppTextStyle.font24SemiBoldCharcoal.copyWith(
                          color: AppColors.white,
                          fontSize: 32.sp,
                        ),
                      ),
                      Text(
                        "on your first order!",
                        style: AppTextStyle.font14RegularSlate600.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                    ),
                    child: Text(
                      "Order Now",
                      style: AppTextStyle.font14BoldPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10.w,
              top: 10.h,
              child: Image.network(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuB4k-usyl5J6sT_cIUwiNKT4I8JbSGA0HGme1FL11FVwg6GSqt1Rr31MDMJShxdksSDVCHTg2I6OdRAYfijb5zLvQhZIh0oVKG0bX7nIRyP3v7rYTOoHfhHtj7iO9LT4OsuMiBulMDAi73dYkMGbFmrMV06E-_L71mp1Tg3QWHvyW7Q8la3Ijf0jaQtToC0g3YsrO2f6OsRoHsQBYEv2ud9XzKzNCqA3eqwIiwFcomAj4C6J7_SDFNG13bpFqNF5CliMJUXNYZ8T_3v",
                height: 130.h,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
