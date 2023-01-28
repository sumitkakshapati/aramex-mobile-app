import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/card/custom_chip.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/common_no_data_widget.dart';
import 'package:aramex/common/widget/text_field/search_textfield.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:aramex/feature/shipping/cubit/all_shipment_bloc.dart';
import 'package:aramex/feature/shipping/cubit/all_shipment_event.dart';
import 'package:aramex/feature/shipping/enum/shipment_status.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';
import 'package:aramex/feature/shipping/ui/widgets/shipment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ShippingWidgets extends StatefulWidget {
  const ShippingWidgets({Key? key}) : super(key: key);

  @override
  State<ShippingWidgets> createState() => _ShippingWidgetsState();
}

class _ShippingWidgetsState extends State<ShippingWidgets> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<ShipmentFilterData> _shipmentFilterData =
      ValueNotifier(ShipmentFilterData.initial());
  final List<Map<String, dynamic>> _shipmentStatus = [
    {"name": "All Shipping", "value": "all-shipment"},
    {
      "name": ShipmentStatus.OnTransit.name,
      "value": ShipmentStatus.OnTransit.value
    },
    {
      "name": ShipmentStatus.Delivered.name,
      "value": ShipmentStatus.Delivered.value
    },
    {
      "name": ShipmentStatus.Returned.name,
      "value": ShipmentStatus.Returned.value
    },
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    context.read<AllShipmentBloc>().add(
          FetchAllShipmentEvent(shipmentFilterData: _shipmentFilterData.value),
        );
    _shipmentFilterData.addListener(_updateData);
    super.initState();
  }

  _updateData() {
    context.read<AllShipmentBloc>().add(
          FetchAllShipmentEvent(shipmentFilterData: _shipmentFilterData.value),
        );
  }

  @override
  void dispose() {
    _shipmentFilterData.removeListener(_updateData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _shipmentRepository =
        RepositoryProvider.of<ShipmentRepository>(context);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            if (scrollNotification.metrics.pixels >
                (scrollNotification.metrics.maxScrollExtent / 2)) {
              context.read<AllShipmentBloc>().add(
                    LoadMoreAllShipmentEvent(
                      shipmentFilterData: _shipmentFilterData.value,
                    ),
                  );
            }
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPinnedHeader(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 12,
                  bottom: 20.hp,
                ),
                color: _theme.scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SearchTextField(
                              hintText: "Search By Shipment ID",
                              bottomPadding: 0,
                              controller: _searchController,
                              onSearched: () {
                                _shipmentFilterData.value =
                                    _shipmentFilterData.value.copyWith(
                                  shipmentId: _searchController.text,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 12.wp),
                          OpenContainer(
                            openElevation: 0,
                            closedElevation: 0,
                            closedBuilder: (context, open) {
                              return Center(
                                child: CustomIconButton(
                                  icon: Icons.photo_filter_rounded,
                                  backgroundColor: _theme.primaryColor,
                                  iconColor: Colors.white,
                                  borderRadius: 12,
                                  padding: 14,
                                ),
                              );
                            },
                            openBuilder: (context, close) {
                              return ShipmentFilterWidgets(
                                shipmentFilterData: _shipmentFilterData.value,
                                onChanged: (value) {
                                  _shipmentFilterData.value = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.hp),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(_shipmentStatus.length, (index) {
                          return CustomChip(
                            label: _shipmentStatus[index]["name"],
                            leftmargin: CustomTheme.symmetricHozPadding,
                            rightMargin: (index == _shipmentStatus.length - 1)
                                ? CustomTheme.symmetricHozPadding
                                : 0,
                            backgroundColor: _currentIndex == index
                                ? CustomTheme.primaryColor
                                : Colors.white,
                            textColor: _currentIndex == index
                                ? Colors.white
                                : CustomTheme.lightTextColor,
                            onPressed: () {
                              setState(() {
                                _currentIndex = index;
                              });
                              _shipmentFilterData.value =
                                  _shipmentFilterData.value.copyWith(
                                status: _shipmentStatus[index]["value"],
                              );
                            },
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocSelector<AllShipmentBloc, CommonState, int>(
              selector: (state) {
                if (state is CommonDataFetchedState<Shipment>) {
                  return state.data.length;
                } else {
                  return 0;
                }
              },
              builder: (context, state) {
                if (state > 0) {
                  return SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding,
                      ),
                      margin: EdgeInsets.only(bottom: 16.hp),
                      child: Text(
                        "${_shipmentRepository.totalShipmentCount == -1 ? 0 : _shipmentRepository.totalShipmentCount} Shipping Found",
                        style: _textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(child: Container());
                }
              },
            ),
            BlocBuilder<AllShipmentBloc, CommonState>(
              buildWhen: (previous, current) {
                if (current is CommonDummyLoadingState) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (context, state) {
                if (state is CommonLoadingState) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: CommonLoadingWidget(),
                  );
                } else if (state is CommonErrorState) {
                  return SliverToBoxAdapter(
                    child: CommonErrorWidget(message: state.message),
                  );
                } else if (state is CommonDataFetchedState<Shipment>) {
                  if (state.data.isNotEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ShipmentCard(
                            horizontalMargin: CustomTheme.symmetricHozPadding,
                            shipment: state.data[index],
                          );
                        },
                        childCount: state.data.length,
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        color: Colors.white,
                        child: const CommonNoDataWidget(
                          message: "No Shipment Available",
                          image: Assets.empty,
                        ),
                      ),
                    );
                  }
                } else {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      color: Colors.white,
                      child: const CommonNoDataWidget(
                        message: "No Shipment Available",
                        image: Assets.empty,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
