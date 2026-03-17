import 'package:flutter/material.dart';
import '../../../features/home/presentation/view/home_view.dart';
import '../../../features/search/presentation/view/search_view.dart';
import '../../../features/orders/presentation/view/orders_view.dart';
import '../../../features/cart/presentation/view/cart_view.dart';
import '../../../features/profile/presentation/view/profile_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _views = const [
    HomeView(),
    SearchView(),
    OrdersView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _views),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.slate300,
          selectedLabelStyle: AppTextStyle.font12MediumSlate300.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: AppTextStyle.font12MediumSlate300,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
