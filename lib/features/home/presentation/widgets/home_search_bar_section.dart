import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeSearchBarSection extends StatelessWidget {
  final String initialValue;
  final Function(String) onSearchChanged;
  final VoidCallback onFilterTapped;

  const HomeSearchBarSection({
    super.key,
    this.initialValue = '',
    required this.onSearchChanged,
    required this.onFilterTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.slate100),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.slate400, size: 20.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                onChanged: onSearchChanged,
                controller: TextEditingController(text: initialValue)
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: initialValue.length),
                  ),
                decoration: InputDecoration(
                  hintText: "Search for food or restaurants",
                  hintStyle: AppTextStyle.font14RegularSlate600,
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: onFilterTapped,
              child: Icon(Icons.tune, color: AppColors.primary, size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
