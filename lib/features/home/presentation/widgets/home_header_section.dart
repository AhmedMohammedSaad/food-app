import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../../../../core/router/routes.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deliver to",
                    style: AppTextStyle.font12MediumSlate300,
                  ),
                  Text("New York, NY", style: AppTextStyle.font14BoldCharcoal),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.favorites);
                },
                icon: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.charcoal,
                    size: 20.r,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBmCdxravhsRcwaRcuNY3P8lEoX18KIeRA9ADzNhiNbGeFQcgnfbgjnfexErbC89kxTooAfKmkWepsMvoVlMs0DIzVD5ASDlB6fZqsZO7DtPVpWFbr1TUa1Una9n3TlUzTq2w3moyJBDfxyXvUsmBDxzDw8VlyXJQ3N-UWrvKJbeDlTi5HAu_CV7hBCT_v1Zzo6hbL1MVw2qJmWh1PmOlYuSn9GSxExDHWv-unSoHbOeNf1CWjyLH6SsKscY4vlLS85-_9lGR16F2If",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
