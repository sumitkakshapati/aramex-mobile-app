import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:boilerplate/common/widget/text_field/search_textfield.dart';
import 'package:boilerplate/feature/shipping/ui/widgets/shipment_card.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ShippingWidgets extends StatelessWidget {
  const ShippingWidgets({Key? key}) : super(key: key);

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
                left: CustomTheme.symmetricHozPadding,
                right: CustomTheme.symmetricHozPadding,
                bottom: 20.hp,
              ),
              color: _theme.scaffoldBackgroundColor,
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
