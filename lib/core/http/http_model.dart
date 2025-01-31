import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:flutter/widgets.dart';

@immutable
class ResponseStateModel<T> {
  final HTTPStatus status;
  final T? data;
  final Map<String, dynamic>? errorResponse;
  final String? errorMessage;

  const ResponseStateModel({
    required this.status,
    this.data,
    this.errorResponse,
    this.errorMessage,
  });

  factory ResponseStateModel.initial() {
    return const ResponseStateModel(status: HTTPStatus.initial);
  }

  ResponseStateModel<T> copyWith({
    HTTPStatus? status,
    T? data,
    Map<String, dynamic>? errorResponse,
    String? errorMessage,
  }) {
    return ResponseStateModel(
      status: status ?? this.status,
      data: data ?? this.data,
      errorResponse: errorResponse ?? this.errorResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@immutable
class HTTPResponseModel<T> {
  final String? code;
  final T? data;
  final String? error;
  final double? latency;
  final String? message;
  final String? result;
  final String? status;
  final int? statusCode;

  const HTTPResponseModel({
    this.code,
    this.data,
    this.error,
    this.latency,
    this.message,
    this.result,
    this.status,
    this.statusCode,
  });

  factory HTTPResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) dataTransformer,
  ) {
    return HTTPResponseModel<T>(
      code: TypeCaster.intoString(json['code']),
      data: dataTransformer(json['data']),
      error: TypeCaster.intoString(json['error']),
      latency: TypeCaster.intoDouble(json['latency']),
      message: TypeCaster.intoString(json['message']),
      result: TypeCaster.intoString(json['result']),
      status: TypeCaster.intoString(json['status']),
      statusCode: TypeCaster.intoInt(json['status_code']),
    );
  }
}

@immutable
class DataPaginationModel<T> {
  final List<T> data;
  final int limit;
  final int offset;
  final int page;
  final int totalRows;

  const DataPaginationModel({
    required this.data,
    required this.limit,
    required this.offset,
    required this.page,
    required this.totalRows,
  });

  factory DataPaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) dataTransformer,
  ) {
    List<T> data = List.empty(growable: true);

    for (var item in List.from(json['data'])) {
      var transformed = dataTransformer(item);
      data.add(transformed);
    }

    return DataPaginationModel(
      data: data,
      limit: TypeCaster.intoInt(json['limit']),
      offset: TypeCaster.intoInt(json['offset']),
      page: TypeCaster.intoInt(json['page']),
      totalRows: TypeCaster.intoInt(json['total_rows']),
    );
  }
}

@immutable
class HTTPPaginationPayloadModel {
  final bool includeTotalRows;
  final QueryOption queryOps;

  const HTTPPaginationPayloadModel({
    this.includeTotalRows = true,
    required this.queryOps,
  });

  HTTPPaginationPayloadModel copyWith({
    bool? includeTotalRows,
    QueryOption? queryOps,
  }) {
    return HTTPPaginationPayloadModel(
      includeTotalRows: includeTotalRows ?? this.includeTotalRows,
      queryOps: queryOps ?? this.queryOps,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'include_total_rows': includeTotalRows,
      'queryops': queryOps.toJson()
    };
  }
}

@immutable
class QueryOption {
  final Map<String, dynamic> filter;
  final Map<String, dynamic> sort;
  final int limit;
  final int offset;
  final int page;

  const QueryOption({
    required this.filter,
    required this.sort,
    required this.limit,
    required this.offset,
    required this.page,
  });

  QueryOption copyWith({
    Map<String, dynamic>? filter,
    Map<String, dynamic>? sort,
    int? limit,
    int? offset,
    int? page,
  }) {
    return QueryOption(
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filter': filter,
      'sort': sort,
      'limit': limit,
      'offset': offset,
      'page': page,
    };
  }
}
