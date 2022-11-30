import 'package:aramex/feature/customer/cubit/customer_details_cubit.dart';
import 'package:aramex/feature/customer/ui/widgets/customer_details_widget.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetailsScreens extends StatelessWidget {
  final String consigneeNumber;
  const CustomerDetailsScreens({Key? key, required this.consigneeNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerDetailsCubit(
        shipmentRepository: RepositoryProvider.of<ShipmentRepository>(context),
      )..searchCustomerDetails(phoneNumber: consigneeNumber),
      child: CustomerDetailsWidgets(
        consigneeNumber: consigneeNumber,
      ),
    );
  }
}
