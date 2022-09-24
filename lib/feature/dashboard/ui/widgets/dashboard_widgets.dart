import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/feature/home/ui/screens/homepage_screens.dart';
import 'package:boilerplate/feature/profile/ui/screens/profile_screens.dart';
import 'package:boilerplate/feature/search/ui/screens/search_page.dart';
import 'package:boilerplate/feature/shipping/ui/screens/shipping_page.dart';
import 'package:flutter/material.dart';

class DashboardWidgets extends StatelessWidget {
  DashboardWidgets({Key? key}) : super(key: key);

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, currentIndex, _) {
            return BottomNavigationBar(
              selectedLabelStyle: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              selectedItemColor: _theme.primaryColor,
              unselectedItemColor: CustomTheme.gray,
              unselectedLabelStyle: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w400,
              ),
              currentIndex: currentIndex,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              showUnselectedLabels: true,
              onTap: (index) {
                _currentIndex.value = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.production_quantity_limits),
                  label: "Shipping",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                )
              ],
            );
          }),
      body: PageView(
        onPageChanged: (index) {
          _currentIndex.value = index;
        },
        controller: _pageController,
        children: [
          HomepageScreens(),
          SearchPage(),
          ShippingPage(),
          ProfileScreens()
        ],
      ),
    );
  }
}
