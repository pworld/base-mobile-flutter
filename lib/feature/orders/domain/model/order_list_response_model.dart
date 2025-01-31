import 'package:app_management_system/shared/helper.dart';

class OrderListResponseModel {
  final DateTime arrivalDateTime;
  final double arrivalDateTimeDiff;
  final String customerName;
  final String customerOrderNumber;
  final DateTime departureDateTime;
  final String departureDateTimeDiff;
  final String destinationCityName;
  final String destinationTimezone;
  final String destinationTimezoneId;
  final bool isReturnTrip;
  final String originCityName;
  final String originTimezone;
  final String originTimezoneId;
  final String jobOrderId;
  final String jobOrderNumber;
  final String jobOrderType;
  final String status;
  final String vehiclePlateNumber;

  OrderListResponseModel({
    required this.arrivalDateTime,
    required this.arrivalDateTimeDiff,
    required this.customerName,
    required this.customerOrderNumber,
    required this.departureDateTime,
    required this.departureDateTimeDiff,
    required this.destinationCityName,
    required this.destinationTimezone,
    required this.destinationTimezoneId,
    required this.isReturnTrip,
    required this.originCityName,
    required this.originTimezone,
    required this.originTimezoneId,
    required this.jobOrderId,
    required this.jobOrderNumber,
    required this.jobOrderType,
    required this.status,
    required this.vehiclePlateNumber,
  });

  factory OrderListResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderListResponseModel(
      arrivalDateTime: TypeCaster.intoDateTime(json['arrival_date_time']),
      arrivalDateTimeDiff: TypeCaster.intoDouble(json['arrival_date_time_diff']),
      customerName: TypeCaster.intoString(json['customer_name']),
      customerOrderNumber: TypeCaster.intoString(json['customer_order_number']),
      departureDateTime: TypeCaster.intoDateTime(json['departure_date_time']),
      departureDateTimeDiff: TypeCaster.intoString(json['departure_date_time_diff']),
      destinationCityName: TypeCaster.intoString(json['destination_city_name']),
      destinationTimezone: TypeCaster.intoString(json['destination_timezone']),
      destinationTimezoneId: TypeCaster.intoString(json['destination_timezone_id']),
      isReturnTrip: TypeCaster.intoBool(json['is_return_trip']),
      originCityName: TypeCaster.intoString(json['origin_city_name']),
      originTimezone: TypeCaster.intoString(json['origin_timezone']),
      originTimezoneId: TypeCaster.intoString(json['origin_timezone_id']),
      jobOrderId: TypeCaster.intoString(json['job_order_id']),
      jobOrderNumber: TypeCaster.intoString(json['job_order_number']),
      jobOrderType: TypeCaster.intoString(json['job_order_type']),
      status: TypeCaster.intoString(json['status']),
      vehiclePlateNumber: TypeCaster.intoString(json['vehicle_plate_number']),
    );
  }
}
