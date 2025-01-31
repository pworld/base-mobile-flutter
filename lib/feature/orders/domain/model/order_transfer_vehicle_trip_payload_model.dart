class OrderTransferVehicleTripPayloadModel{
  final String rowVersion;
  final double addressLatitude;
  final double addressLongitude;

  OrderTransferVehicleTripPayloadModel({
    required this.rowVersion,
    required this.addressLatitude,
    required this.addressLongitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'row_version': rowVersion,
      'address_latitude': addressLatitude,
      'address_longitude': addressLongitude,
    };
  }
}