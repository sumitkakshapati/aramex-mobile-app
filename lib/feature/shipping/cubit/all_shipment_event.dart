import 'package:aramex/feature/home/model/shipment_filter_data.dart';

abstract class AllShipmentEvents {}

class FetchAllShipmentEvent extends AllShipmentEvents {
  ShipmentFilterData? shipmentFilterData;

  FetchAllShipmentEvent({this.shipmentFilterData});
}

class LoadMoreAllShipmentEvent extends AllShipmentEvents {
  ShipmentFilterData? shipmentFilterData;

  LoadMoreAllShipmentEvent({this.shipmentFilterData});
}

class RefreshAllShimentEvent extends AllShipmentEvents {
  ShipmentFilterData? shipmentFilterData;

  RefreshAllShimentEvent({this.shipmentFilterData});
}
