import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/shipping/cubit/all_shipment_event.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllShipmentBloc extends Bloc<AllShipmentEvents, CommonState> {
  final ShipmentRepository shipmentRepository;

  AllShipmentBloc({required this.shipmentRepository})
      : super(CommonInitialState()) {
    on<FetchAllShipmentEvent>((event, emit) async {
      emit(CommonLoadingState());
      final _res = await shipmentRepository.allShipments();
      if (_res.data != null && _res.status == Status.Success) {
        emit(CommonDataFetchedState<Shipment>(data: _res.data!));
      } else {
        emit(CommonErrorState(message: _res.message ?? "Unable to fetch data"));
      }
    });
  }
}
