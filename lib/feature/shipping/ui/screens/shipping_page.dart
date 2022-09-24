import 'package:boilerplate/feature/shipping/ui/widgets/shipping_widgets.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShippingPage extends StatelessWidget {
  const ShippingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShippingWidgets();
  }
}