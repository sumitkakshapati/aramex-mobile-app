import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/date_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/dashboard/cubit/shipment_cities_cubit.dart';
import 'package:aramex/feature/dashboard/model/shipment_cities.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';

class ShipmentFilterWidgets extends StatefulWidget {
  final ShipmentFilterData shipmentFilterData;
  final ValueChanged<ShipmentFilterData> onChanged;
  const ShipmentFilterWidgets({
    Key? key,
    required this.shipmentFilterData,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ShipmentFilterWidgets> createState() => _ShipmentFilterWidgetsState();
}

class _ShipmentFilterWidgetsState extends State<ShipmentFilterWidgets> {
  late ShipmentFilterData _shipmentFilterData;
  final TextEditingController _originCityController = TextEditingController();
  final TextEditingController _destinationCityController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startWeightController = TextEditingController();
  final TextEditingController _endWeightController = TextEditingController();
  final TextEditingController _startPriceController = TextEditingController();
  final TextEditingController _endPriceController = TextEditingController();

  @override
  void initState() {
    _shipmentFilterData = widget.shipmentFilterData;
    _originCityController.text = _shipmentFilterData.originCity ?? "";
    _destinationCityController.text = _shipmentFilterData.destinationCity ?? "";
    _startWeightController.text = _shipmentFilterData.fromKG?.toString() ?? "";
    _endWeightController.text = _shipmentFilterData.toKG?.toString() ?? "";
    _startPriceController.text = _shipmentFilterData.fromRs?.toString() ?? "";
    _endPriceController.text = _shipmentFilterData.toRs?.toString() ?? "";
    _startDateController.text = _shipmentFilterData.startDate != null
        ? Jiffy(_shipmentFilterData.startDate).format("yyyy-MM-dd")
        : "";
    _endDateController.text = _shipmentFilterData.endDate != null
        ? Jiffy(_shipmentFilterData.endDate).format("yyyy-MM-dd")
        : "";
    context.read<ShipmentCitiesCubit>().fetchShipmentCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.filter.tr(),
      ),
      body: BlocBuilder<ShipmentCitiesCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return const CommonLoadingWidget();
          } else if (state is CommonErrorState) {
            return CommonErrorWidget(message: state.message);
          } else if (state is CommonDataSuccessState<ShipmentCities>) {
            return Container(
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
                              label: LocaleKeys.originCity.tr(),
                              hintText: "Choose Origin City",
                              readOnly: true,
                              suffixIcon: Icons.keyboard_arrow_down_rounded,
                              controller: _originCityController,
                              onPressed: () {
                                showOptionsBottomSheet(
                                  label: LocaleKeys.originCity.tr(),
                                  options: state.data!.originCities,
                                  onChanged: (val) {
                                    _originCityController.text = val;
                                  },
                                  context: context,
                                );
                              },
                            ),
                            CustomTextField(
                              label: LocaleKeys.destinationCity.tr(),
                              hintText: "Choose Destination City",
                              readOnly: true,
                              suffixIcon: Icons.keyboard_arrow_down_rounded,
                              bottomPadding: 0,
                              controller: _destinationCityController,
                              onPressed: () {
                                showOptionsBottomSheet(
                                  label: LocaleKeys.destinationCity.tr(),
                                  options: state.data!.destinationCities,
                                  onChanged: (val) {
                                    _destinationCityController.text = val;
                                  },
                                  context: context,
                                );
                              },
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
                                    controller: _startDateController,
                                    onPressed: () async {
                                      final _res = await DateTimeUtils.pickDate(
                                        context: context,
                                        initialDate: DateTime.tryParse(
                                          _startDateController.text,
                                        ),
                                      );
                                      if (_res != null) {
                                        _startDateController.text =
                                            Jiffy(_res).format("yyyy-MM-dd");
                                      }
                                    },
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
                                    controller: _endDateController,
                                    onPressed: () async {
                                      final _res = await DateTimeUtils.pickDate(
                                        context: context,
                                        initialDate: DateTime.tryParse(
                                          _endDateController.text,
                                        ),
                                      );
                                      if (_res != null) {
                                        _endDateController.text =
                                            Jiffy(_res).format("yyyy-MM-dd");
                                      }
                                    },
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
                                    controller: _startWeightController,
                                  ),
                                ),
                                SizedBox(width: 20.wp),
                                Expanded(
                                  child: CustomTextField(
                                    label: LocaleKeys.toKG.tr(),
                                    hintText: "1.0",
                                    bottomPadding: 0,
                                    controller: _endWeightController,
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
                                    controller: _startPriceController,
                                  ),
                                ),
                                SizedBox(width: 20.wp),
                                Expanded(
                                  child: CustomTextField(
                                    label: LocaleKeys.toRs.tr(),
                                    hintText: "10000",
                                    controller: _endPriceController,
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
                              onPressed: () {
                                _originCityController.clear();
                                _destinationCityController.clear();
                                _startDateController.clear();
                                _endDateController.clear();
                                _startWeightController.clear();
                                _endWeightController.clear();
                                _startPriceController.clear();
                                _endPriceController.clear();
                              },
                            ),
                          ),
                          SizedBox(width: 20.wp),
                          Expanded(
                            child: CustomRoundedButtom(
                              title: LocaleKeys.appleFilter.tr(),
                              onPressed: () {
                                final _res = _shipmentFilterData.copyWith(
                                  destinationCity:
                                      _destinationCityController.text,
                                  originCity: _originCityController.text,
                                  startDate: DateTime.tryParse(
                                      _startDateController.text),
                                  endDate: DateTime.tryParse(
                                      _endDateController.text),
                                  fromKG: double.tryParse(
                                      _startWeightController.text),
                                  toKG: double.tryParse(
                                      _endWeightController.text),
                                  fromRs: double.tryParse(
                                      _startPriceController.text),
                                  toRs:
                                      double.tryParse(_endPriceController.text),
                                );
                                widget.onChanged(_res);
                                NavigationService.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
