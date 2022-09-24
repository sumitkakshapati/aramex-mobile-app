import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:boilerplate/common/widget/card/custom_chip.dart';
import 'package:boilerplate/common/widget/text_field/search_textfield.dart';
import 'package:boilerplate/feature/shipping/ui/widgets/shipment_card.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ShippingWidgets extends StatefulWidget {
  const ShippingWidgets({Key? key}) : super(key: key);

  @override
  State<ShippingWidgets> createState() => _ShippingWidgetsState();
}

class _ShippingWidgetsState extends State<ShippingWidgets> {
  final List<String> _shipmentStatus = [
    "All Shipping",
    "On Transit",
    "Received",
    "Returned",
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
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
                        const Expanded(
                          child: SearchTextField(
                            hintText: "Search By Shipment ID",
                            bottomPadding: 0,
                          ),
                        ),
                        SizedBox(width: 12.wp),
                        Center(
                          child: CustomIconButton(
                            icon: Icons.photo_filter_rounded,
                            backgroundColor: _theme.primaryColor,
                            iconColor: Colors.white,
                            borderRadius: 12,
                            padding: 14,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.hp),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_shipmentStatus.length, (index) {
                        return CustomChip(
                          label: _shipmentStatus[index],
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
                          },
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              margin: EdgeInsets.only(bottom: 16.hp),
              child: Text(
                "125 Shipping Found",
                style: _textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const ShipmentCard(
                  horizontalMargin: CustomTheme.symmetricHozPadding,
                );
              },
              childCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
