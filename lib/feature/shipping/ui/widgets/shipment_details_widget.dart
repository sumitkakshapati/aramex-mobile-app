import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/util/number_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/custom_divider.dart';
import 'package:aramex/common/widget/horiontal_key_value.dart';
import 'package:aramex/feature/shipping/cubit/shipment_details_cubit.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class ShipmentDetailsWidgets extends StatelessWidget {
  final int id;
  const ShipmentDetailsWidgets({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.shipmentDetails.tr(),
        // actions: [
        // CustomIconButton(
        //   icon: Icons.picture_as_pdf,
        //   onPressed: () {},
        //   iconColor: CustomTheme.primaryColor,
        // ),
        // ],
      ),
      body: BlocBuilder<ShipmentDetailsCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return const CommonLoadingWidget();
          } else if (state is CommonErrorState) {
            return CommonErrorWidget(message: state.message);
          } else if (state is CommonDataSuccessState<Shipment>) {
            final Shipment _shipment = state.data!;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.hp),
                    Text(
                      LocaleKeys.initialDetails.tr(),
                      style: _textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CardWrapper(
                      topMargin: 16.hp,
                      bottomMargin: 32.hp,
                      child: Column(
                        children: [
                          HorizontalKeyValue(
                            title: LocaleKeys.AWB.tr(),
                            value: _shipment.awbNumber,
                          ),
                          if (_shipment.pickupDate != null)
                            HorizontalKeyValue(
                              title: LocaleKeys.pickUpDate.tr(),
                              value: Jiffy(_shipment.pickupDate)
                                  .format("dd MMMM, yyyy"),
                            ),
                          const CustomDivider(),
                          if (_shipment.productGroup.isNotEmpty)
                            HorizontalKeyValue(
                              title: LocaleKeys.productGroup.tr(),
                              value: _shipment.productGroup,
                            ),
                          if (_shipment.type.isNotEmpty)
                            HorizontalKeyValue(
                              title: LocaleKeys.type.tr(),
                              value: _shipment.type,
                            ),
                          if (_shipment.services.isNotEmpty)
                            HorizontalKeyValue(
                              title: LocaleKeys.service.tr(),
                              value: _shipment.services,
                            ),
                          const CustomDivider(),
                          HorizontalKeyValue(
                            title: LocaleKeys.shipmentNumber.tr(),
                            value: _shipment.shipperNumber,
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.shipperName.tr(),
                            value: _shipment.shipperName,
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.originCity.tr(),
                            value: _shipment.originCity,
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.consigneeTel.tr(),
                            value: _shipment.consigneeTel,
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.destinationCity.tr(),
                            value: _shipment.destinationCity,
                          ),
                          const CustomDivider(),
                          HorizontalKeyValue(
                            title: LocaleKeys.pcs.tr(),
                            value: _shipment.pcs.toString(),
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.chargingWeight.tr(),
                            value: _shipment.chargingWeight.toString(),
                          ),
                          if (_shipment.codLiableBranch.isNotEmpty)
                            HorizontalKeyValue(
                              title: LocaleKeys.codLiableBranch.tr(),
                              value: _shipment.codLiableBranch,
                            ),
                          HorizontalKeyValue(
                            title: LocaleKeys.codPaid.tr(),
                            value: _shipment.codValue.toString(),
                          ),
                          if (_shipment.codPaidDate != null)
                            HorizontalKeyValue(
                              title: LocaleKeys.codPaidDate.tr(),
                              value: Jiffy(_shipment.codPaidDate!)
                                  .format("dd MMMM, yyyy"),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      LocaleKeys.shippingStatus.tr(),
                      style: _textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CardWrapper(
                      topMargin: 16.hp,
                      bottomMargin: 32.hp,
                      child: Column(
                        children: [
                          HorizontalKeyValue(
                            title: LocaleKeys.status.tr(),
                            value: _shipment.status.name,
                          ),
                          if (_shipment.returnStatusDate != null)
                            HorizontalKeyValue(
                              title: LocaleKeys.returnDate.tr(),
                              value: Jiffy(_shipment.returnStatusDate)
                                  .format("dd MMMM, yyyy"),
                            ),
                          if (_shipment.returnReason != null)
                            HorizontalKeyValue(
                              title: LocaleKeys.returnReason.tr(),
                              value: _shipment.returnReason!,
                            ),
                        ],
                      ),
                    ),
                    Text(
                      LocaleKeys.shippingCharge.tr(),
                      style: _textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CardWrapper(
                      topMargin: 16.hp,
                      bottomMargin: 32.hp,
                      child: Column(
                        children: [
                          HorizontalKeyValue(
                            title: LocaleKeys.shippingCharge.tr(),
                            value: _shipment.shippingCharges.formatInRupee(),
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.codFee.tr(),
                            value: _shipment.codFee.formatInRupee(),
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.totalAmountRs.tr(),
                            value: _shipment.totalAmount.formatInRupee(),
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.vatAmountRs.tr(),
                            value: _shipment.vat.formatInRupee(),
                          ),
                          HorizontalKeyValue(
                            title: LocaleKeys.grandTotalRs.tr(),
                            value: _shipment.grandAmount.formatInRupee(),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(child: Container()),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
