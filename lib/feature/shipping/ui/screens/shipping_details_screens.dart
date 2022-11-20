import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/shipping/cubit/shipment_details_cubit.dart';
import 'package:aramex/feature/shipping/ui/widgets/shipment_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentDetailScreens extends StatelessWidget {
  final int id;
  const ShipmentDetailScreens({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShipmentDetailsCubit(
        shipmentRepository: RepositoryProvider.of<ShipmentRepository>(context),
      )..fetchShipmentDetails(id),
      child: ShipmentDetailsWidgets(id: id),
    );
  }
}
