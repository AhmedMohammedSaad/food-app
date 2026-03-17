import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class TrackingMapSection extends StatelessWidget {
  const TrackingMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: double.infinity,
      color: AppColors.slate200, // Placeholder for map
      child: Stack(
        children: [
          // Mock Map Route Line
          Positioned(
            top: 100.h,
            left: 80.w,
            right: 80.w,
            child: CustomPaint(
              size: Size(double.infinity, 100.h),
              painter: DashedLinePainter(),
            ),
          ),
          // Restaurant Marker
          Positioned(
            top: 80.h,
            left: 60.w,
            child: _buildMarker(Icons.storefront, AppColors.charcoal),
          ),
          // Delivery Marker
          Positioned(
            top: 180.h,
            right: 60.w,
            child: _buildMarker(Icons.moped, AppColors.primary),
          ),
          
          // Back Button Overlay
          Positioned(
            top: 50.h,
            left: 20.w,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
            ),
          ),
          
          // Estimated Time Overlay
          Positioned(
            top: 50.h,
            right: 20.w,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primary, size: 18.r),
                    SizedBox(width: 6.w),
                    Text('15 min', style: AppTextStyle.font14BoldCharcoal),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(IconData icon, Color color) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20.r),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, size.height, size.width, size.height);

    // Simple dashed path approximation (Flutter doesn't have native dashed path easily without 3rd party or math)
    // For a complex curve, we just draw a solid line for the mock.
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
