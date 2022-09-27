import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/feature/account_payment/ui/screens/add_wallet_details_screens.dart';
import 'package:aramex/feature/account_payment/ui/widgets/show_account_actions_bottomsheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        SliverList(
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
                  title: "Esewa",
                  description: "984*******",
                  descriptionFontWeight: FontWeight.w400,
                  descriptionFontSize: 14,
                  titleFontSize: 16,
                  suffixIcon: Icons.more_vert,
                  suffixColor: CustomTheme.gray,
                  titleFontWeight: FontWeight.bold,
                  image:
                      "https://p7.hiclipart.com/preview/261/608/1001/esewa-zone-office-bayalbas-google-play-iphone-iphone.jpg",
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
            childCount: 1,
          ),
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
