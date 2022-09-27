import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/feature/account_payment/ui/screens/add_bank_details_screens.dart';
import 'package:aramex/feature/account_payment/ui/widgets/show_account_actions_bottomsheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BankTabWidgets extends StatelessWidget {
  const BankTabWidgets({Key? key}) : super(key: key);

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
                  title: "SunRise Bank",
                  description: "1234 **** **** ****",
                  descriptionFontWeight: FontWeight.w400,
                  descriptionFontSize: 14,
                  titleFontSize: 16,
                  suffixIcon: Icons.more_vert,
                  suffixColor: CustomTheme.gray,
                  titleFontWeight: FontWeight.bold,
                  image:
                      "https://play-lh.googleusercontent.com/bSFfTcSuDPC9EjVA5BrFpCKw38QtRT6fvBU6C5yvQ_imwY8MgUf2ZW2kJOsiwLKi4hc",
                  onPressed: () {
                    showAccountActionsBottomSheet(
                      context: context,
                      onEditDetails: () {
                        NavigationService.push(
                          target: const AddBankDetailsScreens(),
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
                      text: "You can add upto 2 bank accounts",
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
