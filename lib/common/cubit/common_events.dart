abstract class CommonEvents {}

class FetchDataEvent extends CommonEvents {
  int? id;

  FetchDataEvent({this.id});
}

class LoadMoreDataEvent extends CommonEvents {
  int? id;

  LoadMoreDataEvent({this.id});
}

class RefreshDataEvent extends CommonEvents {
  int? id;

  RefreshDataEvent({this.id});
}
