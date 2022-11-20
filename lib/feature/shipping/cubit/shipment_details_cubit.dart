import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentDetailsCubit extends Cubit<CommonState> {
  final ShipmentRepository shipmentRepository;
  ShipmentDetailsCubit({required this.shipmentRepository})
      : super(CommonInitialState());

  fetchShipmentDetails(int id) async {
    emit(CommonLoadingState());
    final _res = await shipmentRepository.shipmentByID(id);
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<Shipment>(data: _res.data!));
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to fetch shipment details"));
    }
  }
}
