class RequestPage {
  final bool includeTotalRows;
  final QueryOps queryOps;

  RequestPage({required this.includeTotalRows, required this.queryOps});

  Map<String, dynamic> toJson() {
    return {
      'include_total_rows': includeTotalRows,
      'queryops': queryOps.toJson(),
    };
  }
}
class QueryOps {
  final Filter filter;
  final int limit;
  final int offset;
  final int page;
  final int totalRows;
  final Sort sort;

  QueryOps({
    required this.filter,
    required this.limit,
    required this.offset,
    required this.page,
    required this.totalRows,
    required this.sort,
  });

  Map<String, dynamic> toJson() {
    return {
      'filter': filter.toJson(),
      'limit': limit,
      'offset': offset,
      'page': page,
      'total_rows': totalRows,
      'sort': sort.toJson(),
    };
  }
}

class Filter {
  final String? customerId;
  final String? status;

  Filter({
    this.customerId,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'status': status
    };
  }
}

class Sort {
  final String? customerCode;
  final String? customerName;
  final String? customerOrderNumber;
  final String? destinationCityName;
  final String? jobOrderDate;
  final String? jobOrderNumber;
  final String? originCityName;
  final String? vehiclePlateNumber;
  final String? vehicleTypeName;

  Sort({
    this.customerCode,
    this.customerName,
    this.customerOrderNumber,
    this.destinationCityName,
    this.jobOrderDate,
    this.jobOrderNumber,
    this.originCityName,
    this.vehiclePlateNumber,
    this.vehicleTypeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_code': customerCode,
      'customer_name': customerName,
      'customer_order_number': customerOrderNumber,
      'destination_city_name': destinationCityName,
      'job_order_date': jobOrderDate,
      'job_order_number': jobOrderNumber,
      'origin_city_name': originCityName,
      'vehicle_plate_number': vehiclePlateNumber,
      'vehicle_type_name': vehicleTypeName,
    };
  }
}
