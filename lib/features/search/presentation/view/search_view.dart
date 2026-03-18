import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../home/presentation/widgets/home_filter_bottom_sheet.dart';
import '../../../home/presentation/widgets/home_search_bar_section.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/search_empty_state_widget.dart';
import '../widgets/search_loading_skeleton.dart';
import '../widgets/search_results_section.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text('Search', style: AppTextStyle.font20SemiBoldCharcoal),
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                String currentQuery = '';
                if (state is SearchSuccess) {
                  currentQuery = state.query;
                }
                return HomeSearchBarSection(
                  initialValue: currentQuery,
                  onSearchChanged: (query) =>
                      context.read<SearchCubit>().search(query),
                  onFilterTapped: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        final searchState = context.read<SearchCubit>().state;
                        String initialSortBy = "Popular";
                        RangeValues initialPriceRange = const RangeValues(0, 100);
                        if (searchState is SearchSuccess) {
                          initialSortBy = searchState.sortBy ?? "Popular";
                          initialPriceRange = searchState.priceRange ?? const RangeValues(0, 100);
                        }
                        return HomeFilterBottomSheet(
                          initialSortBy: initialSortBy,
                          initialPriceRange: initialPriceRange,
                          onApply: (sortBy, priceRange) {
                            context.read<SearchCubit>().applyFilters(sortBy, priceRange);
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const SearchEmptyStateWidget(
                      message: 'Search for your favorite food or restaurant',
                      icon: Icons.search,
                    );
                  } else if (state is SearchLoading) {
                    return const SearchLoadingSkeleton();
                  } else if (state is SearchSuccess) {
                    if (state.restaurants.isEmpty && state.foods.isEmpty) {
                      return SearchEmptyStateWidget(
                        message: 'No results found for "${state.query}"',
                        icon: Icons.search_off,
                      );
                    }
                    return SearchResultsSection(
                      restaurants: state.restaurants,
                      foods: state.foods,
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
