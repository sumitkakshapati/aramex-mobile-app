import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/image/custom_network_image.dart';
import 'package:aramex/feature/authentication/model/user.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/logout_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _userRepository = RepositoryProvider.of<UserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Profile",
          style: _textTheme.headline3!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding),
          child: Column(
            children: [
              ValueListenableBuilder<User?>(
                  valueListenable: _userRepository.user,
                  builder: (context, user, _) {
                    return CardWrapper(
                      topMargin: 20.hp,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomCachedNetworkImage(
                                url: user?.photo?.path ?? "",
                                placeholder: Assets.user,
                                fit: BoxFit.cover,
                                height: 64,
                                width: 64,
                              ),
                              SizedBox(width: 12.wp),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.fullname ?? "",
                                    style: _textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 4.wp),
                                  Text(
                                    user?.email ?? "",
                                    style: _textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4.hp),
                            child: const Divider(
                              color: CustomTheme.gray,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.accountNumber.tr(),
                                      style: _textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: CustomTheme.gray,
                                      ),
                                    ),
                                    SizedBox(height: 4.hp),
                                    Text(
                                      user?.accountNumber ?? "",
                                      style: _textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12.wp),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.totalShipping.tr(),
                                      style: _textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: CustomTheme.gray,
                                      ),
                                    ),
                                    SizedBox(height: 4.hp),
                                    Text(
                                      user?.totalShipmentCount.toString() ?? "",
                                      style: _textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      bottomMargin: 28.hp,
                    );
                  }),
              CardWrapper(
                verticalPadding: 0,
                child: Column(
                  children: [
                    CustomListTile(
                      title: LocaleKeys.personalInformation.tr(),
                      leading: const Icon(Iconsax.user),
                      showNextIcon: true,
                      onPressed: () {
                        NavigationService.pushNamed(
                          routeName: Routes.profileDetails,
                        );
                      },
                    ),
                    CustomListTile(
                      title: LocaleKeys.accountPayment.tr(),
                      leading: const Icon(Iconsax.bank),
                      showNextIcon: true,
                      onPressed: () {
                        NavigationService.pushNamed(
                          routeName: Routes.accountPayment,
                        );
                      },
                    ),
                    CustomListTile(
                      title: LocaleKeys.changePassword.tr(),
                      leading: const Icon(Iconsax.lock),
                      showNextIcon: true,
                      onPressed: () {
                        NavigationService.pushNamed(
                          routeName: Routes.changePassword,
                        );
                      },
                    ),
                    CustomListTile(
                      title: LocaleKeys.paymentHistory.tr(),
                      leading: const Icon(Iconsax.bank),
                      showNextIcon: true,
                      onPressed: () {
                        NavigationService.pushNamed(
                          routeName: Routes.paymentHistory,
                        );
                      },
                    ),
                    CustomListTile(
                      title: LocaleKeys.helpAndSupport.tr(),
                      leading: const Icon(Iconsax.support),
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: LocaleKeys.termsAndConditions.tr(),
                      leading: const Icon(Iconsax.document),
                      showBorder: false,
                      showNextIcon: true,
                    ),
                  ],
                ),
              ),
              CardWrapper(
                verticalPadding: 0,
                topMargin: 28,
                bottomMargin: 32,
                child: CustomListTile(
                  title: LocaleKeys.logout.tr(),
                  titleColor: _theme.primaryColor,
                  onPressed: () {
                    showLogoutDialog(context);
                  },
                  leading: Icon(
                    Iconsax.logout,
                    color: _theme.primaryColor,
                  ),
                  showBorder: false,
                  showNextIcon: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
