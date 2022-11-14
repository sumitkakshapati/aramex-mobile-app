abstract class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonDataSuccessState<T> extends CommonState {
  T? data;

  CommonDataSuccessState({this.data});
}

class CommonDataFetchedState<T> extends CommonState {
  List<T> data;

  CommonDataFetchedState({required this.data});
}

class CommonErrorState extends CommonState {
  final String message;

  CommonErrorState({required this.message});
}
