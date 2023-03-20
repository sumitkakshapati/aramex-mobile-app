import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/home/cubit/homepage_return_details_cubit.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/home/ui/widgets/homepage_return_details_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageReturnDetailsScreens extends StatelessWidget {
  final ShipmentFilterData shipmentFilterData;
  final DateDuration? currentDateDuration;
  const HomepageReturnDetailsScreens({
    Key? key,
    required this.shipmentFilterData,
    required this.currentDateDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageReturnedDetailsCubit(
        shipmentRepository: RepositoryProvider.of<ShipmentRepository>(context),
      )..fetchReturnedShipment(
          shipmentFilterData: shipmentFilterData,
        ),
      child: HomepageReturnDetailsWidgets(
        shipmentFilterData: shipmentFilterData,
        currentDateDuration: currentDateDuration,
      ),
    );
  }
}
