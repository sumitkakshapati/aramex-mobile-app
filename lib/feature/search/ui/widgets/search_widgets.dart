import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/widget/card/custom_list_tile.dart';
import 'package:boilerplate/common/widget/text_field/search_textfield.dart';
import 'package:boxy/slivers.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchWidgets extends StatelessWidget {
  const SearchWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPinnedHeader(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top + 10,
                bottom: 20,
                left: CustomTheme.symmetricHozPadding,
                right: CustomTheme.symmetricHozPadding,
              ),
              color: _theme.scaffoldBackgroundColor,
              child: const SearchTextField(
                hintText: "Search by Consignee number",
                bottomPadding: 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Searches",
                    style: _textTheme.headline6,
                  ),
                  Text(
                    "Clear",
                    style: _textTheme.headline6!.copyWith(
                      color: CustomTheme.skyBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverContainer(
            background: Container(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CustomListTile(
                    title: "9844774503",
                    showNextIcon: true,
                  );
                },
                childCount: 5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
