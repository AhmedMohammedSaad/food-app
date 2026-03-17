import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/data/models/home_models.dart';
import 'circle_button_widget.dart';

class FoodDetailsAppBarSection extends StatelessWidget {
  final FoodModel food;

  const FoodDetailsAppBarSection({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(food.imageUrl, fit: BoxFit.cover),
            Positioned(
              top: 40.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleButtonWidget(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.pop(context),
                  ),
                  CircleButtonWidget(icon: Icons.share, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
