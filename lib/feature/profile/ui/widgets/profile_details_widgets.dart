import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/custom_divider.dart';
import 'package:aramex/common/widget/image/rounded_image.dart';
import 'package:aramex/common/widget/vertical_key_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileDetailsWidgets extends StatelessWidget {
  const ProfileDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.profileDetails.tr(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: CardWrapper(
            topMargin: 32.hp,
            bottomMargin: 32.hp,
            verticalPadding: 32.hp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CustomRoundedImage(
                    height: 96.wp,
                    image: Assets.personImage,
                    width: 96.wp,
                  ),
                ),
                SizedBox(height: 16.hp),
                const Align(
                  alignment: Alignment.center,
                  child: VerticalKeyValue(
                    title: "Sumit Kakshapati",
                    value: "me.summet@gmail.com",
                    titleColor: CustomTheme.lightTextColor,
                    valueColor: CustomTheme.gray,
                    titleFontSize: 20,
                    titleWeight: FontWeight.bold,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                CustomDivider(verticalPadding: 16.hp),
                VerticalKeyValue(
                  title: LocaleKeys.accountNumber.tr(),
                  value: "1234 2345 HM",
                ),
                SizedBox(height: 12.hp),
                VerticalKeyValue(
                  title: LocaleKeys.fullName.tr(),
                  value: "Sumit Kakshapati",
                  verticalPadding: 12.hp,
                ),
                VerticalKeyValue(
                  title: LocaleKeys.email.tr(),
                  value: "me.summet@gmail.com",
                  verticalPadding: 12.hp,
                ),
                VerticalKeyValue(
                  title: LocaleKeys.phoneNumber.tr(),
                  value: "+977 9844774503",
                  verticalPadding: 12.hp,
                ),
                SizedBox(height: 12.hp),
                VerticalKeyValue(
                  title: LocaleKeys.address.tr(),
                  value: "Shankamul, Kathmandu",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
