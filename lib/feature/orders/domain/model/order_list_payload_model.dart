import 'dart:convert';

import 'package:app_management_system/shared/helper.dart';

class OrderListPayloadModel {
  final DateTime? arrivalDateTimeEnd;
  final DateTime? arrivalDateTimeStart;
  final DateTime? createdTimeUtcEnd;
  final DateTime? createdTimeUtcStart;
  final String? customerCode;
  final String? customerId;
  final String? customerName;
  final String? customerOrderId;
  final String? customerOrderNumber;
  final DateTime? departureDateTimeEnd;
  final DateTime? departureDateTimeStart;
  final String? destinationCityId;
  final String? destinationCityName;
  final String? driverId;
  final bool? isActive;
  final DateTime? jobOrderDateEnd;
  final DateTime? jobOrderDateStart;
  final String? jobOrderNumber;
  final String? jobOrderType;
  final String? originCityId;
  final String? originCityName;
  final List<String>? status;
  final DateTime? updatedTimeUtcEnd;
  final DateTime? updatedTimeUtcStart;
  final String? vehicleId;
  final String? vehiclePlateNumber;
  final String? vehicleTypeId;
  final String? vehicleTypeName;

  OrderListPayloadModel({
    this.arrivalDateTimeEnd,
    this.arrivalDateTimeStart,
    this.createdTimeUtcEnd,
    this.createdTimeUtcStart,
    this.customerCode,
    this.customerId,
    this.customerName,
    this.customerOrderId,
    this.customerOrderNumber,
    this.departureDateTimeEnd,
    this.departureDateTimeStart,
    this.destinationCityId,
    this.destinationCityName,
    this.driverId,
    this.isActive,
    this.jobOrderDateEnd,
    this.jobOrderDateStart,
    this.jobOrderNumber,
    this.jobOrderType,
    this.originCityId,
    this.originCityName,
    this.status,
    this.updatedTimeUtcEnd,
    this.updatedTimeUtcStart,
    this.vehicleId,
    this.vehiclePlateNumber,
    this.vehicleTypeId,
    this.vehicleTypeName,
  });

  factory OrderListPayloadModel.fromJson(Map<String, dynamic> json) {
    return OrderListPayloadModel(
      arrivalDateTimeEnd: TypeCaster.intoDateTime(json['arrival_date_time_end']),
      arrivalDateTimeStart: TypeCaster.intoDateTime(json['arrival_date_time_start']),
      createdTimeUtcEnd: TypeCaster.intoDateTime(json['created_time_utc_end']),
      createdTimeUtcStart: TypeCaster.intoDateTime(json['created_time_utc_start']),
      customerCode: TypeCaster.intoString(json['customer_code']),
      customerId: TypeCaster.intoString(json['customer_id']),
      customerName: TypeCaster.intoString(json['customer_name']),
      customerOrderId: TypeCaster.intoString(json['customer_order_id']),
      customerOrderNumber: TypeCaster.intoString(json['customer_order_number']),
      departureDateTimeEnd: TypeCaster.intoDateTime(json['departure_date_time_end']),
      departureDateTimeStart: TypeCaster.intoDateTime(json['departure_date_time_start']),
      destinationCityId: TypeCaster.intoString(json['destination_city_id']),
      destinationCityName: TypeCaster.intoString(json['destination_city_name']),
      driverId: TypeCaster.intoString(json['driver_id']),
      isActive: TypeCaster.intoBool(json['is_active']),
      jobOrderDateEnd: TypeCaster.intoDateTime(json['job_order_date_end']),
      jobOrderDateStart: TypeCaster.intoDateTime(json['job_order_date_start']),
      jobOrderNumber: TypeCaster.intoString(json['job_order_number']),
      jobOrderType: TypeCaster.intoString(json['job_order_type']),
      originCityId: TypeCaster.intoString(json['origin_city_id']),
      originCityName: TypeCaster.intoString(json['origin_city_name']),
      status: List<String>.from(json['status']),
      updatedTimeUtcEnd: TypeCaster.intoDateTime(json['updated_time_utc_end']),
      updatedTimeUtcStart: TypeCaster.intoDateTime(json['updated_time_utc_start']),
      vehicleId: TypeCaster.intoString(json['vehicle_id']),
      vehiclePlateNumber: TypeCaster.intoString(json['vehicle_plate_number']),
      vehicleTypeId: TypeCaster.intoString(json['vehicle_type_id']),
      vehicleTypeName: TypeCaster.intoString(json['vehicle_type_name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arrival_date_time_end': arrivalDateTimeEnd?.toIso8601String(),
      'arrival_date_time_start': arrivalDateTimeStart?.toIso8601String(),
      'created_time_utc_end': createdTimeUtcEnd?.toIso8601String(),
      'created_time_utc_start': createdTimeUtcStart?.toIso8601String(),
      'customer_code': customerCode,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_order_id': customerOrderId,
      'customer_order_number': customerOrderNumber,
      'departure_date_time_end': departureDateTimeEnd?.toIso8601String(),
      'departure_date_time_start': departureDateTimeStart?.toIso8601String(),
      'destination_city_id': destinationCityId,
      'destination_city_name': destinationCityName,
      'driver_id': driverId,
      'is_active': isActive,
      'job_order_date_end': jobOrderDateEnd,
      'job_order_date_start': jobOrderDateStart,
      'job_order_number': jobOrderNumber,
      'job_order_type': jobOrderType,
      'origin_city_id': originCityId,
      'origin_city_name': originCityName,
      'status': jsonEncode(status),
      'updated_time_utc_end': updatedTimeUtcEnd?.toIso8601String(),
      'updated_time_utc_start': updatedTimeUtcStart?.toIso8601String(),
      'vehicle_id': vehicleId,
      'vehicle_plate_number': vehiclePlateNumber,
      'vehicle_type_id': vehicleTypeId,
      'vehicle_type_name': vehicleTypeName,
    }..removeWhere((_, value) => value == null);
  }
}
