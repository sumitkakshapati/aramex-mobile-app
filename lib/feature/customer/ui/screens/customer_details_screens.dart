import 'package:aramex/feature/customer/ui/widgets/customer_details_widget.dart';
import 'package:flutter/material.dart';

class CustomerDetailsScreens extends StatelessWidget {
  final String consigneeNumber;
  const CustomerDetailsScreens({Key? key, required this.consigneeNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomerDetailsWidgets(
      consigneeNumber: consigneeNumber,
    );
  }
}
