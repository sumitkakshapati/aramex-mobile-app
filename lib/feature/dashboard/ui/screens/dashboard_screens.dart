import 'package:aramex/feature/dashboard/cubit/homepage_cubit.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/dashboard/ui/widgets/dashboard_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreens extends StatelessWidget {
  const DashboardScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageCubit(
        shipmentRepository: RepositoryProvider.of<ShipmentRepository>(context)
      ),
      child: DashboardWidgets(),
    );
  }
}
