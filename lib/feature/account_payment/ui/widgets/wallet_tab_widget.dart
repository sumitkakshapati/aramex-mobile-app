import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/feature/account_payment/cubit/user_wallet_list_cubit.dart';
import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/account_payment/ui/screens/add_wallet_details_screens.dart';
import 'package:aramex/feature/account_payment/ui/widgets/show_account_actions_bottomsheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTabWidgets extends StatelessWidget {
  const WalletTabWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        const SliverToBoxAdapter(),
        BlocBuilder<UserWalletListCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoadingState) {
              return const SliverFillRemaining(
                child: CommonLoadingWidget(),
                hasScrollBody: false,
              );
            } else if (state is CommonErrorState) {
              return SliverFillRemaining(
                child: CommonErrorWidget(
                  message: state.message,
                ),
                hasScrollBody: false,
              );
            } else if (state is CommonDataFetchedState<UserWallet>) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(
                        left: CustomTheme.symmetricHozPadding,
                        right: CustomTheme.symmetricHozPadding,
                        bottom: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CustomListTile(
                        title: state.data[index].wallet.name,
                        description: state.data[index].username,
                        descriptionFontWeight: FontWeight.w400,
                        descriptionFontSize: 14,
                        titleFontSize: 16,
                        suffixIcon: Icons.more_vert,
                        suffixColor: CustomTheme.gray,
                        titleFontWeight: FontWeight.bold,
                        image: state.data[index].wallet.media?.path ?? "",
                        onPressed: () {
                          showAccountActionsBottomSheet(
                            context: context,
                            onEditDetails: () {
                              NavigationService.push(
                                target: const AddWalletDetailsScreens(),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                  childCount: state.data.length,
                ),
              );
            } else {
              return const SliverToBoxAdapter();
            }
          },
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding),
            child: RichText(
              text: TextSpan(
                  text: "${LocaleKeys.note.tr()}: ",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "You can add upto 2 wallet accounts",
                      style: _textTheme.headline6,
                    )
                  ]),
            ),
          ),
        )
      ],
    );
  }
}
