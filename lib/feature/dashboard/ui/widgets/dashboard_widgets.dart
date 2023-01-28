import 'package:aramex/app/theme.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/home/ui/screens/homepage_screens.dart';
import 'package:aramex/feature/profile/ui/screens/profile_screens.dart';
import 'package:aramex/feature/search/ui/screens/search_page.dart';
import 'package:aramex/feature/shipping/ui/screens/shipping_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DashboardWidgets extends StatefulWidget {
  const DashboardWidgets({Key? key}) : super(key: key);

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  final PageController _pageController = PageController();

  @override
  void initState() {
    RepositoryProvider.of<UserRepository>(context).fetchProfile();

    super.initState();
  }

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
                _pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.category),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.search_normal),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.box),
                  label: "Shipping",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user),
                  label: "Profile",
                )
              ],
            );
          }),
      body: PageView(
        onPageChanged: (index) {
          _currentIndex.value = index;
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomepageScreens(
            onProfilepressed: () {
              _currentIndex.value = 3;
              _pageController.jumpToPage(3);
            },
          ),
          const SearchPage(),
          const ShippingPage(),
          const ProfileScreens()
        ],
      ),
    );
  }
}
