import 'package:aramex/app/theme.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/text_field/search_textfield.dart';
import 'package:aramex/feature/customer/ui/screens/customer_details_screens.dart';
import 'package:aramex/feature/search/cubit/recent_search_cubit.dart';
import 'package:boxy/slivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchWidgets extends StatefulWidget {
  const SearchWidgets({Key? key}) : super(key: key);

  @override
  State<SearchWidgets> createState() => _SearchWidgetsState();
}

class _SearchWidgetsState extends State<SearchWidgets> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RecentSearchCubit>().getResentSearchList();
  }

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
              child: SearchTextField(
                hintText: "Search by Consignee number",
                bottomPadding: 0,
                controller: _searchController,
                onSearched: () {
                  if (_searchController.text.isNotEmpty) {
                    NavigationService.push(
                      target: CustomerDetailsScreens(
                        consigneeNumber: _searchController.text,
                      ),
                    );
                    context
                        .read<RecentSearchCubit>()
                        .addRecentSearchList(_searchController.text);
                    _searchController.clear();
                  }
                },
              ),
            ),
          ),
          BlocBuilder<RecentSearchCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonDataFetchedState<String>) {
                if (state.data.isNotEmpty) {
                  return SliverToBoxAdapter(
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
                          InkWell(
                            onTap: () {
                              context
                                  .read<RecentSearchCubit>()
                                  .clearSearchList();
                            },
                            child: Text(
                              "Clear",
                              style: _textTheme.headline6!.copyWith(
                                color: CustomTheme.skyBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
              return const SliverToBoxAdapter();
            },
          ),
          SliverContainer(
            background: Container(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding,
            ),
            sliver: BlocBuilder<RecentSearchCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonLoadingState) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: CommonLoadingWidget(),
                  );
                } else if (state is CommonDataFetchedState<String>) {
                  if (state.data.isNotEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return CustomListTile(
                            title: state.data[index],
                            showNextIcon: true,
                            onPressed: () {
                              NavigationService.push(
                                target: CustomerDetailsScreens(
                                  consigneeNumber: state.data[index],
                                ),
                              );
                            },
                          );
                        },
                        childCount: state.data.length,
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "You have not searched anything yet.",
                          style: _textTheme.headline5,
                        ),
                      ),
                    );
                  }
                } else {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "You have not searched anything yet.",
                        style: _textTheme.headline5,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
