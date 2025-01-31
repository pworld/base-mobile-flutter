// PaginationsModel<List<RequestJobOrderList>> apiRequest = PaginationsModel.fromJson(
//   jsonResponse,
//       (data) => List<RequestJobOrderList>.from(
//     (data['data'] as List).map((item) => RequestJobOrderList.fromJson(item as Map<String, dynamic>)),
//   ),
// );

class DataContainer<T> {
  final String? code;
  final PaginationsModel<T>? data;
  final String? error;
  final int? latency;
  final String? message;
  final String? result;
  final String? status;
  final int? statusCode;

  DataContainer({
    this.code,
    this.data,
    this.error,
    this.latency,
    this.message,
    this.result,
    this.status,
    this.statusCode,
  });

  factory DataContainer.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return DataContainer<T>(
      code: json['code'] as String?,
      data: json['data'] != null ? PaginationsModel.fromJson(json['data'], fromJsonT) : null,
      error: json['error'] as String?,
      latency: json['latency'] as int?,
      message: json['message'] as String?,
      result: json['result'] as String?,
      status: json['status'] as String?,
      statusCode: json['status_code'] as int?,
    );
  }

  Map<String, dynamic> toJson(T Function(T value) toJsonT) {
    return {
      'code': code,
      'data': data?.toJson(toJsonT),
      'error': error,
      'latency': latency,
      'message': message,
      'result': result,
      'status': status,
      'status_code': statusCode,
    };
  }
}

class PaginationsModel<T> {
  final List<T>? data;
  final int? limit;
  final int? offset;
  final int? page;
  final int? totalRows;

  PaginationsModel({
    this.data,
    this.limit,
    this.offset,
    this.page,
    this.totalRows,
  });

  factory PaginationsModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    var jsonData = json['data'];
    List<T> dataList;

    // Check if jsonData is a list or a single map and convert accordingly
    if (jsonData is List) {
      dataList = jsonData.map<T>((item) => fromJsonT(item as Map<String, dynamic>)).toList();
    } else if (jsonData is Map) {
      dataList = [fromJsonT(jsonData as Map<String, dynamic>)]; // Create a list containing the single item
    } else {
      dataList = []; // Initialize with an empty list if data is not a List or Map
    }

    return PaginationsModel<T>(
      data: dataList,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      page: json['page'] as int?,
      totalRows: json['total_rows'] as int?,
    );
  }

  Map<String, dynamic> toJson(T Function(T value) toJsonT) {
    return {
      'data': data?.map((T value) => toJsonT(value)).toList(),
      'limit': limit,
      'offset': offset,
      'page': page,
      'total_rows': totalRows,
    };
  }
}

