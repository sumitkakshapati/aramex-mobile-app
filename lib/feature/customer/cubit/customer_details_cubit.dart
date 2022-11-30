import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/customer/model/customer_details.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetailsCubit extends Cubit<CommonState> {
  final ShipmentRepository shipmentRepository;
  CustomerDetailsCubit({required this.shipmentRepository})
      : super(CommonInitialState());

  searchCustomerDetails({
    required String phoneNumber,
    ShipmentFilterData? shipmentFilterData,
  }) async {
    emit(CommonLoadingState());
    final _res = await shipmentRepository.fetchCustomerDetails(
      phoneNumber: phoneNumber,
      shipmentFilterData: shipmentFilterData,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<CustomerDetails>(data: _res.data));
    } else {
      emit(
        CommonErrorState(
          message: _res.message ?? "Unable to fetch customer details",
        ),
      );
    }
  }
}
