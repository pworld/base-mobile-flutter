import 'package:app_management_system/shared/helper.dart';
import 'package:intl/intl.dart';

class RequestJobOrderList {
  final String? createdTimeUtcEnd;
  final String? createdTimeUtcStart;
  final String? customerCode;
  final String? customerId;
  final String? customerName;
  final String? customerOrderId;
  final String? customerOrderNumber;
  final String? destinationCityId;
  final String? destinationCityName;
  final String? jobOrderDateEnd;
  final String? jobOrderDateStart;
  final String jobOrderNumber;
  final String? originCityId;
  final String? originCityName;
  final String? status;
  final String? updatedTimeUtcEnd;
  final String? updatedTimeUtcStart;
  final String? vehicleId;
  final String? vehiclePlateNumber;
  final String? vehicleTypeId;
  final String? vehicleTypeName;

  RequestJobOrderList({
    this.createdTimeUtcEnd,
    this.createdTimeUtcStart,
    this.customerCode,
    this.customerId,
    this.customerName,
    this.customerOrderId,
    this.customerOrderNumber,
    this.destinationCityId,
    this.destinationCityName,
    this.jobOrderDateEnd,
    this.jobOrderDateStart,
    required this.jobOrderNumber,
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

  factory RequestJobOrderList.fromJson(Map<String, dynamic> json) {
    return RequestJobOrderList(
      createdTimeUtcEnd: json['created_time_utc_end'] as String?,
      createdTimeUtcStart: json['created_time_utc_start'] as String?,
      customerCode: json['customer_code'] as String?,
      customerId: json['customer_id'] as String?,
      customerName: json['customer_name'] as String?,
      customerOrderId: json['customer_order_id'] as String?,
      customerOrderNumber: json['customer_order_number'] as String?,
      destinationCityId: json['destination_city_id'] as String?,
      destinationCityName: json['destination_city_name'] as String?,
      jobOrderDateEnd: json['job_order_date_end'] as String?,
      jobOrderDateStart: json['job_order_date_start'] as String?,
      jobOrderNumber: json['job_order_number'] as String,
      originCityId: json['origin_city_id'] as String?,
      originCityName: json['origin_city_name'] as String?,
      status: json['status'] as String?,
      updatedTimeUtcEnd: json['updated_time_utc_end'] as String?,
      updatedTimeUtcStart: json['updated_time_utc_start'] as String?,
      vehicleId: json['vehicle_id'] as String?,
      vehiclePlateNumber: json['vehicle_plate_number'] as String?,
      vehicleTypeId: json['vehicle_type_id'] as String?,
      vehicleTypeName: json['vehicle_type_name'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "created_time_utc_end": createdTimeUtcEnd,
      "created_time_utc_start": createdTimeUtcStart,
      "customer_code": customerCode,
      "customer_id": customerId,
      "customer_name": customerName,
      "customer_order_id": customerOrderId,
      "customer_order_number": customerOrderNumber,
      "destination_city_id": destinationCityId,
      "destination_city_name": destinationCityName,
      "job_order_date_end": jobOrderDateEnd,
      "job_order_date_start": jobOrderDateStart,
      "job_order_number": jobOrderNumber,
      "origin_city_id": originCityId,
      "origin_city_name": originCityName,
      "status": status,
      "updated_time_utc_end": updatedTimeUtcEnd,
      "updated_time_utc_start": updatedTimeUtcStart,
      "vehicle_id": vehicleId,
      "vehicle_plate_number": vehiclePlateNumber,
      "vehicle_type_id": vehicleTypeId,
      "vehicle_type_name": vehicleTypeName
    };
  }
}

class ResponseJobOrderList {
  final String jobOrderId;
  // final String tenantId; Removed for Now
  final String jobOrderNumber;
  final String jobOrderType;
  final DateTime jobOrderDate;
  final String customerOrderId;
  final String customerId;
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
  final int routeReturnLeadTime;
  final DateTime departureDateTime;
  final DateTime actualDepartureDateTime;
  final int departureDateTimeDiff;
  final DateTime arrivalDateTime;
  final DateTime actualArrivalDateTime;
  final int arrivalDateTimeDiff;
  final DateTime finishDateTime;
  final DateTime actualFinishDateTime;
  final int finishDateTimeDiff;
  final int actualLeadTime;
  final bool isReturnTrip;
  final DateTime returnDateTime;
  final DateTime actualReturnDateTime;
  final int returnDateTimeDiff;
  final String nextDestinationCityId;
  final String nextDestinationCityName;
  final DateTime nextDestinationArrivalDateTime;
  final DateTime nextDestinationEstArrivalDateTime;
  final int nextDestinationArrivalDateTimeEstDelay;
  final String nextDestinationTimeZoneId;
  final int nextDestinationTimeZoneOffset;
  final int taskCount;
  final int taskCompleted;
  final double revenueAmount;
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
  // final String uniqueKey; Removed for Now
  final String createdUserId;
  final DateTime createdTimeUtc;
  final String updatedUserId;
  final DateTime updatedTimeUtc;
  final String rowVersion;
  final String? vehiclePlateNumber;
  final String? vehicleTypeId;
  final String? vehicleTypeName;
  final String? customerOrderNumber;
  final String? customerCode;
  final String? customerName;
  final String? driverEmployeeNumber;

  ResponseJobOrderList({
    required this.jobOrderId,
    // required this.tenantId,  Removed for Now
    required this.jobOrderNumber,
    required this.jobOrderType,
    required this.jobOrderDate,
    required this.customerOrderId,
    required this.customerId,
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
    this.routeReturnLeadTime = 0,
    required this.departureDateTime,
    required this.actualDepartureDateTime,
    this.departureDateTimeDiff = 0,
    required this.arrivalDateTime,
    required this.actualArrivalDateTime,
    this.arrivalDateTimeDiff = 0,
    required this.finishDateTime,
    required this.actualFinishDateTime,
    this.finishDateTimeDiff = 0,
    this.actualLeadTime = 0,
    this.isReturnTrip = false,
    required this.returnDateTime,
    required this.actualReturnDateTime,
    this.returnDateTimeDiff = 0,
    this.nextDestinationCityId = '',
    this.nextDestinationCityName = '',
    required this.nextDestinationArrivalDateTime,
    required this.nextDestinationEstArrivalDateTime,
    this.nextDestinationArrivalDateTimeEstDelay = 0,
    this.nextDestinationTimeZoneId = '',
    this.nextDestinationTimeZoneOffset = 0,
    this.taskCount = 0,
    this.taskCompleted = 0,
    this.revenueAmount = 0.0,
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
    // required this.uniqueKey, Removed for Now
    required this.createdUserId,
    required this.createdTimeUtc,
    required this.updatedUserId,
    required this.updatedTimeUtc,
    required this.rowVersion,
    this.vehiclePlateNumber,
    this.vehicleTypeId,
    this.vehicleTypeName,
    this.customerOrderNumber,
    this.customerCode,
    this.customerName,
    this.driverEmployeeNumber,
  });

  factory ResponseJobOrderList.fromJson(Map<String, dynamic> json) {
    var fmt = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return ResponseJobOrderList(
      jobOrderId: json['job_order_id'],
      // tenantId: 'json['tenant_id']',  Removed for Now
      jobOrderNumber: json['job_order_number'],
      jobOrderType: json['job_order_type'],
      jobOrderDate: fmt.parse(json['job_order_date']),
      customerOrderId: json['customer_order_id'],
      customerId: json['customer_id'],
      vehicleId: json['vehicle_id'],
      driverId: json['driver_id'],
      customRoute: json['custom_route'] ?? false,
      routeId: json['route_id'],
      originCityId: json['origin_city_id'],
      originCityName: json['origin_city_name'],
      originTimeZoneId: json['origin_timezone_id'],
      originTimeZoneOffset: json['origin_timezone_offset'],
      destinationCityId: json['destination_city_id'],
      destinationCityName: json['destination_city_name'],
      destinationTimeZoneId: json['destination_timezone_id'],
      destinationTimeZoneOffset: json['destination_timezone_offset'],
      routeLeadTime: json['route_lead_time'] ?? 0,
      routeReturnLeadTime: json['route_return_lead_time'] ?? 0,
      departureDateTime: fmt.parse(json['departure_date_time']),
      actualDepartureDateTime: json['actual_departure_date_time'] != null ? fmt.parse(json['actual_departure_date_time']) : DateTime.now(),
      departureDateTimeDiff: json['departure_date_time_diff'] ?? 0,
      arrivalDateTime: fmt.parse(json['arrival_date_time']),
      actualArrivalDateTime: json['actual_arrival_date_time'] != null ? fmt.parse(json['actual_arrival_date_time']) : DateTime.now(),
      arrivalDateTimeDiff: json['arrival_date_time_diff'] ?? 0,
      finishDateTime: fmt.parse(json['finish_date_time']),
      actualFinishDateTime: json['actual_finish_date_time'] != null ? fmt.parse(json['actual_finish_date_time']) : DateTime.now(),
      finishDateTimeDiff: json['finish_date_time_diff'] ?? 0,
      actualLeadTime: json['actual_lead_time'] ?? 0,
      isReturnTrip: json['is_return_trip'] ?? false,
      returnDateTime: json['return_date_time'] != null ? fmt.parse(json['return_date_time']) : DateTime.now(),
      actualReturnDateTime: json['actual_return_date_time'] != null ? fmt.parse(json['actual_return_date_time']) : DateTime.now(),
      returnDateTimeDiff: json['return_date_time_diff'] ?? 0,
      nextDestinationCityId: json['next_destination_city_id'],
      nextDestinationCityName: json['next_destination_city_name'],
      nextDestinationArrivalDateTime: json['next_destination_arrival_date_time'] != null ? fmt.parse(json['next_destination_arrival_date_time']) : DateTime.now(),
      nextDestinationEstArrivalDateTime: json['next_destination_est_arrival_date_time'] != null ? fmt.parse(json['next_destination_est_arrival_date_time']) : DateTime.now(),
      nextDestinationArrivalDateTimeEstDelay: json['next_destination_arrival_date_time_est_delay'] ?? 0,
      nextDestinationTimeZoneId: json['next_destination_timezone_id'],
      nextDestinationTimeZoneOffset: json['next_destination_timezone_offset'] ?? 0,
      taskCount: json['task_count'] ?? 0,
      taskCompleted: json['task_completed'] ?? 0,
      revenueAmount: toDoubleSafe(json['revenue_amount']),
      tripExpenseAmount: toDoubleSafe(json['trip_expense_amount']),
      defaultTripExpenseAmount: toDoubleSafe(json['default_trip_expense_amount']),
      tripExpenseAmountDiff: toDoubleSafe(json['trip_expense_amount_diff']),
      tripExpensePaidAmount: toDoubleSafe(json['trip_expense_paid_amount']),
      tripExpenseUnpaidAmount: toDoubleSafe(json['trip_expense_unpaid_amount']),
      isTripExpenseAmountFullyPaid: json['is_trip_expense_amount_fully_paid'] ?? false,
      tripExpenseAmountLastPaymentDateTime: json['trip_expense_amount_last_payment_date_time'] != null ? fmt.parse(json['trip_expense_amount_last_payment_date_time']) : DateTime.now(),
      note: json['note'],
      driverNote: json['driver_note'],
      status: json['status'],
      isActive: json['is_active'] ?? true,
      isDeleted: json['is_deleted'] ?? false,
      // uniqueKey: json['unique_key'], Removed for Now
      createdUserId: json['created_user_id'],
      createdTimeUtc: fmt.parse(json['created_time_utc']),
      updatedUserId: json['updated_user_id'],
      updatedTimeUtc: fmt.parse(json['updated_time_utc']),
      rowVersion: json['row_version'],
      vehiclePlateNumber: json['vehicle_plate_number'] as String?,
      vehicleTypeId: json['vehicle_type_id'] as String?,
      vehicleTypeName: json['vehicle_type_name'] as String?,
      customerOrderNumber: json['customer_order_number'] as String?,
      customerCode: json['customer_code'] as String?,
      customerName: json['customer_name'] as String?,
      driverEmployeeNumber: json['driver_employee_number'] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    var fmt = DateFormat('yyyy-MM-ddTHH:mm:ssZ');  // This format should match your actual need
    return {
      'job_order_id': jobOrderId.toString(),
      // 'tenant_id': tenantId.toString(), Removed for Now
      'job_order_number': jobOrderNumber,
      'job_order_type': jobOrderType,
      'job_order_date': fmt.format(jobOrderDate),
      'customer_order_id': customerOrderId.toString(),
      'customer_id': customerId.toString(),
      'vehicle_id': vehicleId.toString(),
      'driver_id': driverId.toString(),
      'custom_route': customRoute,
      'route_id': routeId.toString(),
      'origin_city_id': originCityId,
      'origin_city_name': originCityName,
      'origin_timezone_id': originTimeZoneId,
      'origin_timezone_offset': originTimeZoneOffset,
      'destination_city_id': destinationCityId,
      'destination_city_name': destinationCityName,
      'destination_timezone_id': destinationTimeZoneId,
      'destination_timezone_offset': destinationTimeZoneOffset,
      'route_lead_time': routeLeadTime,
      'route_return_lead_time': routeReturnLeadTime,
      'departure_date_time': fmt.format(departureDateTime),
      'actual_departure_date_time': actualDepartureDateTime != null ? fmt.format(actualDepartureDateTime) : null,
      'departure_date_time_diff': departureDateTimeDiff,
      'arrival_date_time': fmt.format(arrivalDateTime),
      'actual_arrival_date_time': actualArrivalDateTime != null ? fmt.format(actualArrivalDateTime) : null,
      'arrival_date_time_diff': arrivalDateTimeDiff,
      'finish_date_time': fmt.format(finishDateTime),
      'actual_finish_date_time': actualFinishDateTime != null ? fmt.format(actualFinishDateTime) : null,
      'finish_date_time_diff': finishDateTimeDiff,
      'actual_lead_time': actualLeadTime,
      'is_return_trip': isReturnTrip,
      'return_date_time': returnDateTime != null ? fmt.format(returnDateTime) : null,
      'actual_return_date_time': actualReturnDateTime != null ? fmt.format(actualReturnDateTime) : null,
      'return_date_time_diff': returnDateTimeDiff,
      'next_destination_city_id': nextDestinationCityId,
      'next_destination_city_name': nextDestinationCityName,
      'next_destination_arrival_date_time': nextDestinationArrivalDateTime != null ? fmt.format(nextDestinationArrivalDateTime) : null,
      'next_destination_est_arrival_date_time': nextDestinationEstArrivalDateTime != null ? fmt.format(nextDestinationEstArrivalDateTime) : null,
      'next_destination_arrival_date_time_est_delay': nextDestinationArrivalDateTimeEstDelay,
      'next_destination_timezone_id': nextDestinationTimeZoneId,
      'next_destination_timezone_offset': nextDestinationTimeZoneOffset,
      'task_count': taskCount,
      'task_completed': taskCompleted,
      'revenue_amount': revenueAmount,
      'trip_expense_amount': tripExpenseAmount,
      'default_trip_expense_amount': defaultTripExpenseAmount,
      'trip_expense_amount_diff': tripExpenseAmountDiff,
      'trip_expense_paid_amount': tripExpensePaidAmount,
      'trip_expense_unpaid_amount': tripExpenseUnpaidAmount,
      'is_trip_expense_amount_fully_paid': isTripExpenseAmountFullyPaid,
      'trip_expense_amount_last_payment_date_time': tripExpenseAmountLastPaymentDateTime != null ? fmt.format(tripExpenseAmountLastPaymentDateTime) : null,
      'note': note,
      'driver_note': driverNote,
      'status': status,
      'is_active': isActive,
      'is_deleted': isDeleted,
      // 'unique_key': uniqueKey, Removed for Now
      'created_user_id': createdUserId.toString(),
      'created_time_utc': fmt.format(createdTimeUtc),
      'updated_user_id': updatedUserId.toString(),
      'updated_time_utc': fmt.format(updatedTimeUtc),
      'row_version': rowVersion.toString(),
      "vehicle_plate_number": vehiclePlateNumber,
      "vehicle_type_id": vehicleTypeId,
      "vehicle_type_name": vehicleTypeName,
      "customer_order_number": customerOrderNumber,
      "customer_code": customerCode,
      "customer_name": customerName,
      "driver_employee_number": driverEmployeeNumber,
    };
  }
}


