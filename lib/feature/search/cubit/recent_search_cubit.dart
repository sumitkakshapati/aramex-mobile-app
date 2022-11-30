import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/shared_pref/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchCubit extends Cubit<CommonState> {
  RecentSearchCubit() : super(CommonInitialState());

  getResentSearchList() async {
    emit(CommonLoadingState());
    final _res = await SharedPref.getSearchItem();
    emit(CommonDataFetchedState<String>(data: _res));
  }

  addRecentSearchList(String searchItem) async {
    emit(CommonLoadingState());
    final _ = await SharedPref.addSearchItem(searchItem);
    final _res = await SharedPref.getSearchItem();
    emit(CommonDataFetchedState<String>(data: _res));
  }

  clearSearchList() async {
    emit(CommonLoadingState());
    final _ = await SharedPref.clearSearchList();
    emit(CommonDataFetchedState<String>(data: []));
  }
}
