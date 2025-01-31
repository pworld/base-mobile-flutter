import 'package:app_management_system/shared/helper.dart';
import 'package:intl/intl.dart';

class RequestTransferVehicleModel{
  final String statusTrip;
  final String jobOrderNumber;
  final String? jobOrderDateEnd;
  final String? jobOrderDateStart;

  RequestTransferVehicleModel({
    required this.statusTrip,
    required this.jobOrderNumber,
    required this.jobOrderDateEnd,
    required this.jobOrderDateStart,
  });

  factory RequestTransferVehicleModel.fromJson(Map<String, dynamic> json) {
    return RequestTransferVehicleModel(
      statusTrip: json['status_trip'] as String,
      jobOrderNumber: json['job_order_number'] as String,
      jobOrderDateEnd: json['job_order_date_end'] as String,
      jobOrderDateStart: json['job_order_start_end'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status_trip': statusTrip,
      'job_order_number': jobOrderNumber,
      'job_order_date_end': jobOrderDateEnd,
      'job_order_start_end': jobOrderDateStart,
    };
  }
}

class ResponseTransferVehicleModel {
  final String jobOrderId;
  final String jobOrderNumber;
  final String jobOrderType;
  final DateTime jobOrderDate;
  final String vehicleId;
  final String driverId;
  final bool customRoute;
  final String routeId;
  final String originCityId;
  final String originCityName;
  final String originTimeZoneId;
  final int originTimeZoneOffset;
  final String destinationCityId;
  final String destinationCityName;
  final String destinationTimeZoneId;
  final int destinationTimeZoneOffset;
  final int routeLeadTime;
  final DateTime departureDateTime;
  final DateTime actualDepartureDateTime;
  final int departureDateTimeDiff;
  final DateTime arrivalDateTime;
  final DateTime actualArrivalDateTime;
  final int arrivalDateTimeDiff;
  final int actualLeadTime;
  final String nextDestinationCityId;
  final String nextDestinationCityName;
  final DateTime nextDestinationArrivalDateTime;
  final DateTime nextDestinationEstArrivalDateTime;
  final int nextDestinationArrivalDateTimeEstDelay;
  final String nextDestinationTimeZoneId;
  final int nextDestinationTimeZoneOffset;
  final int taskCount;
  final int taskCompleted;
  final double tripExpenseAmount;
  final double defaultTripExpenseAmount;
  final double tripExpenseAmountDiff;
  final double tripExpensePaidAmount;
  final double tripExpenseUnpaidAmount;
  final bool isTripExpenseAmountFullyPaid;
  final DateTime tripExpenseAmountLastPaymentDateTime;
  final String note;
  final String driverNote;
  final String status;
  final bool isActive;
  final bool isDeleted;
  final String createdUserId;
  final DateTime createdTimeUtc;
  final String updatedUserId;
  final DateTime updatedTimeUtc;
  final String rowVersion;
  final String transferReason;
  final String destinationAddressStreet;
  final String destinationAddressStreet2;
  final String destinationAddressSubdistrictId;
  final String destinationAddressSubdistrictName;
  final String destinationAddressCityId;
  final String destinationAddressCityName;
  final String destinationAddressProvinceId;
  final String destinationAddressProvinceName;
  final String destinationAddressCountryId;
  final String destinationAddressCountryName;
  final String destinationAddressZipcode;
  final double destinationAddressLongitude;
  final double destinationAddressLatitude;
  final String vehiclePlateNumber;
  final String vehicleTypeId;
  final String vehicleTypeName;
  final String driverEmployeeNumber;
  final String driverFullName;

  ResponseTransferVehicleModel({
    required this.jobOrderId,
    required this.jobOrderNumber,
    required this.jobOrderType,
    required this.jobOrderDate,
    required this.vehicleId,
    required this.driverId,
    this.customRoute = false,
    required this.routeId,
    required this.originCityId,
    required this.originCityName,
    required this.originTimeZoneId,
    required this.originTimeZoneOffset,
    required this.destinationCityId,
    required this.destinationCityName,
    required this.destinationTimeZoneId,
    required this.destinationTimeZoneOffset,
    this.routeLeadTime = 0,
    required this.departureDateTime,
    required this.actualDepartureDateTime,
    this.departureDateTimeDiff = 0,
    required this.arrivalDateTime,
    required this.actualArrivalDateTime,
    this.arrivalDateTimeDiff = 0,
    this.actualLeadTime = 0,
    this.nextDestinationCityId = '',
    this.nextDestinationCityName = '',
    required this.nextDestinationArrivalDateTime,
    required this.nextDestinationEstArrivalDateTime,
    this.nextDestinationArrivalDateTimeEstDelay = 0,
    this.nextDestinationTimeZoneId = '',
    this.nextDestinationTimeZoneOffset = 0,
    this.taskCount = 0,
    this.taskCompleted = 0,
    this.tripExpenseAmount = 0.0,
    this.defaultTripExpenseAmount = 0.0,
    this.tripExpenseAmountDiff = 0.0,
    this.tripExpensePaidAmount = 0.0,
    this.tripExpenseUnpaidAmount = 0.0,
    this.isTripExpenseAmountFullyPaid = false,
    required this.tripExpenseAmountLastPaymentDateTime,
    this.note = '',
    this.driverNote = '',
    required this.status,
    this.isActive = true,
    this.isDeleted = false,
    required this.createdUserId,
    required this.createdTimeUtc,
    required this.updatedUserId,
    required this.updatedTimeUtc,
    required this.rowVersion,
    required this.transferReason,
    required this.destinationAddressStreet,
    required this.destinationAddressStreet2,
    required this.destinationAddressSubdistrictId,
    required this.destinationAddressSubdistrictName,
    required this.destinationAddressCityId,
    required this.destinationAddressCityName,
    required this.destinationAddressProvinceId,
    required this.destinationAddressProvinceName,
    required this.destinationAddressCountryId,
    required this.destinationAddressCountryName,
    required this.destinationAddressZipcode,
    required this.destinationAddressLongitude,
    required this.destinationAddressLatitude,
    required this.vehiclePlateNumber,
    required this.vehicleTypeId,
    required this.vehicleTypeName,
    required this.driverEmployeeNumber,
    required this.driverFullName,
  });

  factory ResponseTransferVehicleModel.fromJson(Map<String, dynamic> json) {
    var fmt = DateFormat('yyyy-MM-ddTHH:mm:ssZ');  // Adjust the format to match your date strings in JSON
    return ResponseTransferVehicleModel(
      jobOrderId: json['job_order_id'],
      jobOrderNumber: json['job_order_number'],
      jobOrderType: json['job_order_type'],
      jobOrderDate: fmt.parse(json['job_order_date']),
      vehicleId: json['vehicle_id'],
      driverId: json['driver_id'],
      customRoute: json['custom_route'],
      routeId: json['route_id'],
      originCityId: json['origin_city_id'],
      originCityName: json['origin_city_name'],
      originTimeZoneId: json['origin_timezone_id'],
      originTimeZoneOffset: json['origin_timezone_offset'],
      destinationCityId: json['destination_city_id'],
      destinationCityName: json['destination_city_name'],
      destinationTimeZoneId: json['destination_timezone_id'],
      destinationTimeZoneOffset: json['destination_timezone_offset'],
      routeLeadTime: json['route_lead_time'],
      departureDateTime: fmt.parse(json['departure_date_time']),
      actualDepartureDateTime: fmt.parse(json['actual_departure_date_time']),
      departureDateTimeDiff: json['departure_date_time_diff'],
      arrivalDateTime: fmt.parse(json['arrival_date_time']),
      actualArrivalDateTime: fmt.parse(json['actual_arrival_date_time']),
      arrivalDateTimeDiff: json['arrival_date_time_diff'],
      actualLeadTime: json['actual_lead_time'],
      nextDestinationCityId: json['next_destination_city_id'],
      nextDestinationCityName: json['next_destination_city_name'],
      nextDestinationArrivalDateTime: fmt.parse(json['next_destination_arrival_date_time']),
      nextDestinationEstArrivalDateTime: fmt.parse(json['next_destination_est_arrival_date_time']),
      nextDestinationArrivalDateTimeEstDelay: json['next_destination_arrival_date_time_est_delay'],
      nextDestinationTimeZoneId: json['next_destination_timezone_id'],
      nextDestinationTimeZoneOffset: json['next_destination_timezone_offset'],
      taskCount: json['task_count'],
      taskCompleted: json['task_completed'],
      tripExpenseAmount: toDoubleSafe(json['trip_expense_amount']),
      defaultTripExpenseAmount: toDoubleSafe(json['default_trip_expense_amount']),
      tripExpenseAmountDiff: toDoubleSafe(json['trip_expense_amount_diff']),
      tripExpensePaidAmount: toDoubleSafe(json['trip_expense_paid_amount']),
      tripExpenseUnpaidAmount: toDoubleSafe(json['trip_expense_unpaid_amount']),
      isTripExpenseAmountFullyPaid: json['is_trip_expense_amount_fully_paid'],
      tripExpenseAmountLastPaymentDateTime: fmt.parse(json['trip_expense_amount_last_payment_date_time']),
      note: json['note'],
      driverNote: json['driver_note'],
      status: json['status'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdUserId: json['created_user_id'],
      createdTimeUtc: fmt.parse(json['created_time_utc']),
      updatedUserId: json['updated_user_id'],
      updatedTimeUtc: fmt.parse(json['updated_time_utc']),
      rowVersion: json['row_version'],
      transferReason: json['transfer_reason'],
      destinationAddressStreet: json['destination_address_street'],
      destinationAddressStreet2: json['destination_address_street2'],
      destinationAddressSubdistrictId: json['destination_address_subdistrict_id'],
      destinationAddressSubdistrictName: json['destination_address_subdistrict_name'],
      destinationAddressCityId: json['destination_address_city_id'],
      destinationAddressCityName: json['destination_address_city_name'],
      destinationAddressProvinceId: json['destination_address_province_id'],
      destinationAddressProvinceName: json['destination_address_province_name'],
      destinationAddressCountryId: json['destination_address_country_id'],
      destinationAddressCountryName: json['destination_address_country_name'],
      destinationAddressZipcode: json['destination_address_zipcode'],
      destinationAddressLongitude: toDoubleSafe(json['destination_address_longitude']),
      destinationAddressLatitude: toDoubleSafe(json['destination_address_latitude']),
      vehiclePlateNumber: json['vehicle_plate_number'],
      vehicleTypeId: json['vehicle_type_id'],
      vehicleTypeName: json['vehicle_type_name'],
      driverEmployeeNumber: json['driver_employee_number'],
      driverFullName: json['driver_full_name'],
    );
  }


  Map<String, dynamic> toJson() {
    var fmt = DateFormat('yyyy-MM-ddTHH:mm:ssZ');  // This format should match your actual date-time usage
    return {
      'job_order_id': jobOrderId,
      'job_order_number': jobOrderNumber,
      'job_order_type': jobOrderType,
      'job_order_date': fmt.format(jobOrderDate),
      'vehicle_id': vehicleId,
      'driver_id': driverId,
      'custom_route': customRoute,
      'route_id': routeId,
      'origin_city_id': originCityId,
      'origin_city_name': originCityName,
      'origin_timezone_id': originTimeZoneId,
      'origin_timezone_offset': originTimeZoneOffset,
      'destination_city_id': destinationCityId,
      'destination_city_name': destinationCityName,
      'destination_timezone_id': destinationTimeZoneId,
      'destination_timezone_offset': destinationTimeZoneOffset,
      'route_lead_time': routeLeadTime,
      'departure_date_time': fmt.format(departureDateTime),
      'actual_departure_date_time': fmt.format(actualDepartureDateTime),
      'departure_date_time_diff': departureDateTimeDiff,
      'arrival_date_time': fmt.format(arrivalDateTime),
      'actual_arrival_date_time': fmt.format(actualArrivalDateTime),
      'arrival_date_time_diff': arrivalDateTimeDiff,
      'actual_lead_time': actualLeadTime,
      'next_destination_city_id': nextDestinationCityId,
      'next_destination_city_name': nextDestinationCityName,
      'next_destination_arrival_date_time': fmt.format(nextDestinationArrivalDateTime),
      'next_destination_est_arrival_date_time': fmt.format(nextDestinationEstArrivalDateTime),
      'next_destination_arrival_date_time_est_delay': nextDestinationArrivalDateTimeEstDelay,
      'next_destination_timezone_id': nextDestinationTimeZoneId,
      'next_destination_timezone_offset': nextDestinationTimeZoneOffset,
      'task_count': taskCount,
      'task_completed': taskCompleted,
      'trip_expense_amount': tripExpenseAmount,
      'default_trip_expense_amount': defaultTripExpenseAmount,
      'trip_expense_amount_diff': tripExpenseAmountDiff,
      'trip_expense_paid_amount': tripExpensePaidAmount,
      'trip_expense_unpaid_amount': tripExpenseUnpaidAmount,
      'is_trip_expense_amount_fully_paid': isTripExpenseAmountFullyPaid,
      'trip_expense_amount_last_payment_date_time': fmt.format(tripExpenseAmountLastPaymentDateTime),
      'note': note,
      'driver_note': driverNote,
      'status': status,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_user_id': createdUserId,
      'created_time_utc': fmt.format(createdTimeUtc),
      'updated_user_id': updatedUserId,
      'updated_time_utc': fmt.format(updatedTimeUtc),
      'row_version': rowVersion,
      'transfer_reason': transferReason,
      'destination_address_street': destinationAddressStreet,
      'destination_address_street2': destinationAddressStreet2,
      'destination_address_subdistrict_id': destinationAddressSubdistrictId,
      'destination_address_subdistrict_name': destinationAddressSubdistrictName,
      'destination_address_city_id': destinationAddressCityId,
      'destination_address_city_name': destinationAddressCityName,
      'destination_address_province_id': destinationAddressProvinceId,
      'destination_address_province_name': destinationAddressProvinceName,
      'destination_address_country_id': destinationAddressCountryId,
      'destination_address_country_name': destinationAddressCountryName,
      'destination_address_zipcode': destinationAddressZipcode,
      'destination_address_longitude': destinationAddressLongitude,
      'destination_address_latitude': destinationAddressLatitude,
      'vehicle_plate_number': vehiclePlateNumber,
      'vehicle_type_id': vehicleTypeId,
      'vehicle_type_name': vehicleTypeName,
      'driver_employee_number': driverEmployeeNumber,
      'driver_full_name': driverFullName,
    };
  }
}

class RequestTransferVehicleTripModel{
  final String statusTrip;
  final String jobOrderId;
  final double addressLatitude;
  final double addressLongitude;
  final String? rowVersion;

  RequestTransferVehicleTripModel({
    required this.statusTrip,
    required this.jobOrderId,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.rowVersion,
  });

  factory RequestTransferVehicleTripModel.fromJson(Map<String, dynamic> json) {
    return RequestTransferVehicleTripModel(
      statusTrip: json['status_trip'] as String,
      jobOrderId: json['job_order_id'] as String,
      addressLatitude: json['address_latitude'] as double,
      addressLongitude: json['address_longitude'] as double,
      rowVersion: json['row_version'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status_trip': statusTrip,
      'job_order_id': jobOrderId,
      'address_latitude': addressLatitude,
      'address_longitude': addressLongitude,
      'row_version': rowVersion,
    };
  }
}


