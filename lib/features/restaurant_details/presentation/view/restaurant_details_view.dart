import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/data/models/home_models.dart';
import '../cubit/restaurant_details_cubit.dart';
import '../widgets/restaurant_details_app_bar_section.dart';
import '../widgets/restaurant_header_section.dart';
import '../widgets/restaurant_menu_section.dart';

class RestaurantDetailsView extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailsView({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RestaurantDetailsCubit>()..loadRestaurantDetails(restaurant.id),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: CustomScrollView(
          slivers: [
            RestaurantDetailsAppBarSection(restaurant: restaurant),
            SliverToBoxAdapter(
              child: RestaurantHeaderSection(restaurant: restaurant),
            ),
            const RestaurantMenuSection(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
