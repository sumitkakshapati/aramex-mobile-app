import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/dashboard/model/shipment_cities.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentCitiesCubit extends Cubit<CommonState> {
  final ShipmentRepository shipmentRepository;
  ShipmentCitiesCubit({required this.shipmentRepository})
      : super(CommonInitialState());

  fetchShipmentCities() async {
    emit(CommonLoadingState());
    final _res = await shipmentRepository.fetchShipmentCities();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<ShipmentCities>(data: _res.data!));
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to load shipment cities"));
    }
  }
}
