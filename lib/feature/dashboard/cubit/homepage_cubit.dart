import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/common/util/date_utils.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageCubit extends Cubit<CommonState> {
  ShipmentRepository shipmentRepository;
  HomepageCubit({required this.shipmentRepository})
      : super(CommonInitialState());

  homepage() async {
    emit(CommonLoadingState());
    final _currentDateRange = DateTimeUtils.getDateRange(DateDuration.Week);
    final _res = await shipmentRepository.homepage(
      shipmentFilterData: ShipmentFilterData.initial().copyWith(
        startDate: _currentDateRange.start,
        endDate: _currentDateRange.end,
      ),
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<HomepageData>(data: _res.data));
    } else {
      emit(
        CommonErrorState(
          message: _res.message ?? "Unable to fetch homepage data",
        ),
      );
    }
  }

  updateHomepage({
    ShipmentFilterData? shipmentFilterData,
  }) async {
    emit(CommonDummyLoadingState());
    final _res = await shipmentRepository.homepage(
        shipmentFilterData: shipmentFilterData);
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<HomepageData>(data: _res.data));
    } else {
      emit(
        CommonErrorState(
          message: _res.message ?? "Unable to fetch homepage data",
        ),
      );
    }
  }
}
