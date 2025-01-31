import 'package:app_management_system/shared/helper.dart';

class OrderTransferVehicleResponseModel {
  final DateTime arrivalDateTime;
  final double arrivalDateTimeDiff;
  final String customerName;
  final String customerOrderNumber;
  final DateTime departureDateTime;
  final String departureDateTimeDiff;
  final String destinationAddressStreet;
  final String destinationAddressStreet2;
  final String destinationAddressSubdistrictName;
  final String destinationAddressCityName;
  final String destinationAddressProvinceName;
  final String destinationAddressCountryName;
  final String destinationAddressZipcode;
  final double destinationAddressLongitude;
  final double destinationAddressLatitude;
  final String destinationCityName;
  final String destinationTimezone;
  final String destinationTimezoneId;
  final String driverNote;
  final String originCityName;
  final String originTimezone;
  final String originTimezoneId;
  final String jobOrderId;
  final String jobOrderNumber;
  final String jobOrderType;
  final String rowVersion;
  final String status;
  final String transferReason;
  final String tripExpenseAmount;
  final String vehiclePlateNumber;

  OrderTransferVehicleResponseModel({
    required this.arrivalDateTime,
    required this.arrivalDateTimeDiff,
    required this.customerName,
    required this.customerOrderNumber,
    required this.departureDateTime,
    required this.departureDateTimeDiff,
    required this.destinationAddressStreet,
    required this.destinationAddressStreet2,
    required this.destinationAddressSubdistrictName,
    required this.destinationAddressCityName,
    required this.destinationAddressProvinceName,
    required this.destinationAddressCountryName,
    required this.destinationAddressZipcode,
    required this.destinationAddressLongitude,
    required this.destinationAddressLatitude,
    required this.destinationCityName,
    required this.destinationTimezone,
    required this.destinationTimezoneId,
    required this.driverNote,
    required this.originCityName,
    required this.originTimezone,
    required this.originTimezoneId,
    required this.jobOrderId,
    required this.jobOrderNumber,
    required this.jobOrderType,
    required this.rowVersion,
    required this.status,
    required this.transferReason,
    required this.tripExpenseAmount,
    required this.vehiclePlateNumber,
  });

  factory OrderTransferVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderTransferVehicleResponseModel(
      arrivalDateTime: TypeCaster.intoDateTime(json['arrival_date_time']),
      arrivalDateTimeDiff: TypeCaster.intoDouble(json['arrival_date_time_diff']),
      customerName: TypeCaster.intoString(json['customer_name']),
      customerOrderNumber: TypeCaster.intoString(json['customer_order_number']),
      departureDateTime: TypeCaster.intoDateTime(json['departure_date_time']),
      departureDateTimeDiff: TypeCaster.intoString(json['departure_date_time_diff']),
      destinationAddressStreet: TypeCaster.intoString(json['destination_address_street']),
      destinationAddressStreet2: TypeCaster.intoString(json['destination_address_street2']),
      destinationAddressSubdistrictName: TypeCaster.intoString(json['destination_address_subdistrict_name']),
      destinationAddressCityName: TypeCaster.intoString(json['destination_address_city_name']),
      destinationAddressProvinceName: TypeCaster.intoString(json['destination_address_province_name']),
      destinationAddressCountryName: TypeCaster.intoString(json['destination_address_country_name']),
      destinationAddressZipcode: TypeCaster.intoString(json['destination_address_zipcode']),
      destinationAddressLongitude: TypeCaster.intoDouble(json['destination_address_longitude']),
      destinationAddressLatitude: TypeCaster.intoDouble(json['destination_address_latitude']),
      destinationCityName: TypeCaster.intoString(json['destination_city_name']),
      destinationTimezone: TypeCaster.intoString(json['destination_timezone']),
      destinationTimezoneId: TypeCaster.intoString(json['destination_timezone_id']),
      driverNote: TypeCaster.intoString(json['driver_note']),
      originCityName: TypeCaster.intoString(json['origin_city_name']),
      originTimezone: TypeCaster.intoString(json['origin_timezone']),
      originTimezoneId: TypeCaster.intoString(json['origin_timezone_id']),
      jobOrderId: TypeCaster.intoString(json['job_order_id']),
      jobOrderNumber: TypeCaster.intoString(json['job_order_number']),
      jobOrderType: TypeCaster.intoString(json['job_order_type']),
      rowVersion: TypeCaster.intoString(json['row_version']),
      status: TypeCaster.intoString(json['status']),
      transferReason: TypeCaster.intoString(json['transfer_reason']),
      tripExpenseAmount: TypeCaster.intoString(json['trip_expense_amount']),
      vehiclePlateNumber: TypeCaster.intoString(json['vehicle_plate_number']),
    );
  }
}
