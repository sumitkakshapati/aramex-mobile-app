import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/assets.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:boilerplate/common/widget/card/custom_list_tile.dart';
import 'package:boilerplate/common/widget/card_wrapper.dart';
import 'package:boilerplate/common/widget/image/rounded_image.dart';
import 'package:flutter/material.dart';

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          CustomIconButton(
            icon: Icons.notifications,
            onPressed: () {},
          ),
          SizedBox(width: 16.wp),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding),
          child: Column(
            children: [
              CardWrapper(
                topMargin: 28.hp,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CustomRoundedImage(
                          height: 64,
                          width: 64,
                          image: Assets.personImage,
                        ),
                        SizedBox(width: 12.wp),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sumit Kakshapati",
                              style: _textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4.wp),
                            Text(
                              "me.summet@gmail.com",
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
                                "Account Number",
                                style: _textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.gray,
                                ),
                              ),
                              SizedBox(height: 4.hp),
                              Text(
                                "1235 123456",
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
                                "Total Shipping",
                                style: _textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.gray,
                                ),
                              ),
                              SizedBox(height: 4.hp),
                              Text(
                                "75,000",
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
              ),
              CardWrapper(
                verticalPadding: 0,
                child: Column(
                  children: [
                    CustomListTile(
                      title: "Personal Information",
                      leading: const Icon(Icons.person),
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: "Account payment",
                      leading: const Icon(Icons.payment),
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: "Change Password",
                      leading: const Icon(Icons.lock),
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: "Payment History",
                      leading: const Icon(Icons.payment),
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: "Help and Support",
                      leading: const Icon(Icons.help),
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: "Terms and Condition",
                      leading: const Icon(Icons.dock),
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
                  title: "Log Out",
                  titleColor: _theme.primaryColor,
                  leading: Icon(
                    Icons.logout_rounded,
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
