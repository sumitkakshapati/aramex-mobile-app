import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/locale_keys.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/button/custom_outline_button.dart';
import 'package:boilerplate/common/widget/button/rounded_button.dart';
import 'package:boilerplate/common/widget/custom_app_bar.dart';
import 'package:boilerplate/common/widget/text_field/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShipmentFilterWidgets extends StatelessWidget {
  const ShipmentFilterWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.filter.tr(),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.only(bottom: 24.hp),
                        child: Text(
                          LocaleKeys.deliveryLocations.tr(),
                          style: _textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      CustomTextField(
                        label: LocaleKeys.country.tr(),
                        hintText: "Choose Country",
                        readOnly: true,
                        suffixIcon: Icons.keyboard_arrow_down_rounded,
                      ),
                      CustomTextField(
                        label: LocaleKeys.originCity.tr(),
                        hintText: "Choose Origin City",
                        readOnly: true,
                        suffixIcon: Icons.keyboard_arrow_down_rounded,
                      ),
                      CustomTextField(
                        label: LocaleKeys.destinationCity.tr(),
                        hintText: "Choose Destination City",
                        readOnly: true,
                        suffixIcon: Icons.keyboard_arrow_down_rounded,
                        bottomPadding: 0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.hp),
                        child: Divider(
                          height: 0,
                          color: CustomTheme.gray.withOpacity(0.4),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 24.hp),
                        child: Text(
                          LocaleKeys.dateTime.tr(),
                          style: _textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: LocaleKeys.fromDate.tr(),
                              hintText: "Start Date",
                              suffixIcon: Iconsax.calendar_1,
                              readOnly: true,
                              bottomPadding: 0,
                            ),
                          ),
                          SizedBox(width: 20.wp),
                          Expanded(
                            child: CustomTextField(
                              label: LocaleKeys.toDate.tr(),
                              hintText: "End Date",
                              suffixIcon: Iconsax.calendar_1,
                              bottomPadding: 0,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.hp),
                        child: Divider(
                          height: 0,
                          color: CustomTheme.gray.withOpacity(0.4),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 24.hp),
                        child: Text(
                          LocaleKeys.weightRange.tr(),
                          style: _textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: LocaleKeys.fromKG.tr(),
                              hintText: "0.5",
                              bottomPadding: 0,
                            ),
                          ),
                          SizedBox(width: 20.wp),
                          Expanded(
                            child: CustomTextField(
                              label: LocaleKeys.toKG.tr(),
                              hintText: "1.0",
                              bottomPadding: 0,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.hp),
                        child: Divider(
                          height: 0,
                          color: CustomTheme.gray.withOpacity(0.4),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 24.hp),
                        child: Text(
                          LocaleKeys.priceRange.tr(),
                          style: _textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: LocaleKeys.fromRs.tr(),
                              hintText: "1000",
                            ),
                          ),
                          SizedBox(width: 20.wp),
                          Expanded(
                            child: CustomTextField(
                              label: LocaleKeys.toRs.tr(),
                              hintText: "10000",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomOutlineButton(
                        title: LocaleKeys.clear.tr(),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20.wp),
                    Expanded(
                      child: CustomRoundedButtom(
                        title: LocaleKeys.appleFilter.tr(),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
