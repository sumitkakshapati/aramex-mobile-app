import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/text_utils.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/custom_divider.dart';
import 'package:aramex/common/widget/image/custom_network_image.dart';
import 'package:aramex/common/widget/vertical_key_value.dart';
import 'package:aramex/feature/authentication/model/user.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailsWidgets extends StatelessWidget {
  const ProfileDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userRepo = RepositoryProvider.of<UserRepository>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.profileDetails.tr(),
      ),
      body: ValueListenableBuilder<User?>(
          valueListenable: _userRepo.user,
          builder: (context, user, _) {
            return SingleChildScrollView(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomCachedNetworkImage(
                            url: user?.photo?.path ?? "",
                            height: 96.wp,
                            fit: BoxFit.cover,
                            placeholder: Assets.user,
                            width: 96.wp,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.hp),
                      Align(
                        alignment: Alignment.center,
                        child: VerticalKeyValue(
                          title: user?.fullname.capitalize() ?? "",
                          value: user?.email ?? "",
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
                        value: user?.accountNumber.capitalize() ?? "",
                      ),
                      SizedBox(height: 12.hp),
                      VerticalKeyValue(
                        title: LocaleKeys.fullName.tr(),
                        value: user?.fullname.capitalize() ?? "",
                        verticalPadding: 12.hp,
                      ),
                      VerticalKeyValue(
                        title: LocaleKeys.email.tr(),
                        value: user?.email ?? "",
                        verticalPadding: 12.hp,
                      ),
                      VerticalKeyValue(
                        title: LocaleKeys.phoneNumber.tr(),
                        value: user?.phone ?? "",
                        verticalPadding: 12.hp,
                      ),
                      SizedBox(height: 12.hp),
                      VerticalKeyValue(
                        title: LocaleKeys.address.tr(),
                        value: user?.address.capitalize() ?? "",
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
