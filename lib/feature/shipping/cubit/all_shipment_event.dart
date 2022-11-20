abstract class AllShipmentEvents {}

class FetchAllShipmentEvent extends AllShipmentEvents {
  int? id;

  FetchAllShipmentEvent({this.id});
}

class LoadMoreAllShipmentEvent extends AllShipmentEvents {
  int? id;

  LoadMoreAllShipmentEvent({this.id});
}

class RefreshAllShimentEvent extends AllShipmentEvents {
  int? id;

  RefreshAllShimentEvent({this.id});
}
