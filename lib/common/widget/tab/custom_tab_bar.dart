import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/tab/custom_tab.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final TabController tabController;
  final double topMargin;
  const CustomTabBar({
    Key? key,
    this.topMargin = 24,
    required this.tabs,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(
        top: topMargin,
        left: CustomTheme.symmetricHozPadding,
        right: CustomTheme.symmetricHozPadding,
        bottom: 10.hp,
      ),
      padding: EdgeInsets.symmetric(vertical: 6.hp, horizontal: 6.wp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        labelStyle: _textTheme.headline6!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: CustomTheme.lightTextColor,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          color: _theme.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        tabs: List.generate(
          tabs.length,
          (index) {
            return CustomTab(
              label: tabs[index],
              selected: tabController.index == index,
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(topMargin + 60);
  }
}
