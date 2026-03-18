import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';

class HomeFilterBottomSheet extends StatefulWidget {
  final String initialSortBy;
  final RangeValues initialPriceRange;
  final Function(String sortBy, RangeValues priceRange) onApply;

  const HomeFilterBottomSheet({
    super.key,
    required this.initialSortBy,
    required this.initialPriceRange,
    required this.onApply,
  });

  @override
  State<HomeFilterBottomSheet> createState() => _HomeFilterBottomSheetState();
}

class _HomeFilterBottomSheetState extends State<HomeFilterBottomSheet> {
  String _selectedSort = "Popular";
  RangeValues _priceRange = const RangeValues(0, 100);

  final List<String> _sortOptions = [
    "Popular",
    "Nearest",
    "Rating",
    "Cheapest",
  ];

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.initialSortBy;
    _priceRange = widget.initialPriceRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filter", style: AppTextStyle.font18SemiBoldCharcoal),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text("Sort By", style: AppTextStyle.font16SemiBoldCharcoal),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: _sortOptions.map((option) {
              final isSelected = _selectedSort == option;
              return ChoiceChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedSort = option;
                  });
                },
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.slate600,
                  fontSize: 14.sp,
                ),
                backgroundColor: AppColors.slate100,
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),
          Text("Price Range", style: AppTextStyle.font16SemiBoldCharcoal),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels(
              "\$${_priceRange.start.round()}",
              "\$${_priceRange.end.round()}",
            ),
            activeColor: AppColors.primary,
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          SizedBox(height: 32.h),
          AppDefaultButton(
            text: "Apply Filter",
            onPressed: () {
              widget.onApply(_selectedSort, _priceRange);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
