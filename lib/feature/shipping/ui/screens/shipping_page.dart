import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/shipping/cubit/all_shipment_bloc.dart';
import 'package:aramex/feature/shipping/ui/widgets/shipping_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingPage extends StatelessWidget {
  const ShippingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllShipmentBloc(
        shipmentRepository: RepositoryProvider.of<ShipmentRepository>(context),
      ),
      child: const ShippingWidgets(),
    );
  }
}
