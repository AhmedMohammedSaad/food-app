import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/tracking_driver_info_section.dart';
import '../widgets/tracking_map_section.dart';
import '../widgets/tracking_status_section.dart';

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TrackingMapSection(),
            SizedBox(height: 20.h),
            const TrackingDriverInfoSection(),
            const TrackingStatusSection(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
