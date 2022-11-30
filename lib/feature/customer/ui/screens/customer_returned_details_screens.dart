import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/feature/customer/cubit/customer_return_details_cubit.dart';
import 'package:aramex/feature/customer/ui/widgets/customer_return_details_widgets.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerReturnDetailsScreens extends StatelessWidget {
  final String phoneNumber;
  final ShipmentFilterData shipmentFilterData;
   final DateDuration? currentDateDuration;
  const CustomerReturnDetailsScreens({
    Key? key,
    required this.phoneNumber,
    required this.shipmentFilterData,
    required this.currentDateDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerReturnedDetailsCubit(
        shipmentRepository: RepositoryProvider.of<ShipmentRepository>(context),
      )..fetchReturnedShipment(
          number: phoneNumber,
          shipmentFilterData: shipmentFilterData,
        ),
      child: CustomerReturnDetailsWidgets(
        phoneNumber: phoneNumber,
        shipmentFilterData: shipmentFilterData,
        currentDateDuration: currentDateDuration,
      ),
    );
  }
}
