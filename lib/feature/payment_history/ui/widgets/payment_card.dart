import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/text_utils.dart';
import 'package:aramex/common/widget/vertical_key_value.dart';
import 'package:aramex/feature/payment_history/model/payment_request.dart';
import 'package:aramex/feature/payment_history/ui/widgets/payment_actions_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class PaymentCard extends StatelessWidget {
  final double horizontalMargin;
  final double bottomMargin;
  final PaymentRequest paymentRequest;
  const PaymentCard({
    Key? key,
    this.horizontalMargin = 0,
    this.bottomMargin = 16,
    required this.paymentRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        bottom: bottomMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 16.wp, bottom: 16.wp),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 16.hp),
                  child: Text(
                    paymentRequest.paymentRequestId,
                    style: _textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.wp),
              InkWell(
                onTap: () {
                  showPaymentActionsBottomSheet(
                    context: context,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8.hp),
                  padding: EdgeInsets.symmetric(vertical: 8.hp, horizontal: 16),
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: CustomTheme.gray,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8.hp),
          Row(
            children: [
              Expanded(
                child: VerticalKeyValue(
                  title: "Request Amount",
                  value: "Rs. ${paymentRequest.amount}",
                ),
              ),
              SizedBox(width: 12.wp),
              Expanded(
                child: VerticalKeyValue(
                  title: "Completed Date",
                  value: paymentRequest.completedAt != null
                      ? Jiffy(paymentRequest.completedAt!)
                          .format("dd MMMM,yyyy")
                      : "N/A",
                ),
              ),
              const SizedBox(width: CustomTheme.symmetricHozPadding),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(right: CustomTheme.symmetricHozPadding),
            child: Divider(
              color: CustomTheme.gray.withOpacity(0.4),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: VerticalKeyValue(
                  title: "Status",
                  value: paymentRequest.paymentStatus.name.capitalize(),
                  valueColor: CustomTheme.purple,
                ),
              ),
              SizedBox(width: 12.wp),
              Expanded(
                child: VerticalKeyValue(
                  title: "Payment Type",
                  value: paymentRequest.option.formatedName.capitalize(),
                ),
              ),
              const SizedBox(width: CustomTheme.symmetricHozPadding),
            ],
          ),
        ],
      ),
    );
  }
}
