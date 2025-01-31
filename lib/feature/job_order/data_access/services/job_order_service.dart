import 'package:dartz/dartz.dart';
import 'package:app_management_system/core/services/failure.dart';
import 'package:app_management_system/feature/job_order/domain/model/job_order_model.dart';
import 'package:app_management_system/shared/services/base_services.dart';

import '../../../../shared/services/request_paginations_model.dart';
import '../../../../shared/services/response_message_model.dart';
import '../../../../shared/services/response_paginations_model.dart';
import '../../domain/model/transfer_vehicle_model.dart';

class JobOrderNewServices extends BaseService {
  Future<Either<Failure, ResponseJobOrderList>> fetchJobOrderHistories(String id) async {

    return request<ResponseJobOrderList>(
      method: 'GET',
      path: 'job-orders/$id/trip-status-histories',
      payload: {},
      fromJson: (json) => ResponseJobOrderList.fromJson(json),
    );
  }

  Future<Either<Failure, PaginationsModel<ResponseJobOrderList>>> fetchJobOrders(RequestPage payload) async {
    return request<PaginationsModel<ResponseJobOrderList>>(
      method: 'POST',
      path: 'job-orders',
      payload: payload.toJson(),
      fromJson: (json) => PaginationsModel<ResponseJobOrderList>.fromJson(
        json,
            (dataJson) => ResponseJobOrderList.fromJson(dataJson),
      ),
    );
  }

  Future<Either<Failure, ResponseTransferVehicleModel>> fetchJobOrderTransferVehicle(String id) async {

    return request<ResponseTransferVehicleModel>(
      method: 'GET',
      path: 'job-order-vehicle-transfers/$id',
      payload: {},
      fromJson: (json) => ResponseTransferVehicleModel.fromJson(json),
    );
  }

  Future<Either<Failure, ResponseMessageModel>> jobOrderTransferVehicleStartTrip(RequestTransferVehicleTripModel payload) async {
    return request<ResponseMessageModel>(
      method: 'PUT',
      path: 'job-order-vehicle-transfers/${payload.jobOrderId}/start-trip',  // Use variables here directly
      payload: payload.toJson(),  // Assuming you have a toJson method in your RequestTransferVehicleTripModel
      fromJson: (json) => ResponseMessageModel.fromJson(json),
    );
  }

  Future<Either<Failure, ResponseMessageModel>> jobOrderTransferVehicleFinishTrip(RequestTransferVehicleTripModel payload) async {
    return request<ResponseMessageModel>(
      method: 'PUT',
      path: 'job-order-vehicle-transfers/${payload.jobOrderId}/finish-trip',  // Use variables here directly
      payload: payload.toJson(),  // Assuming you have a toJson method in your RequestTransferVehicleTripModel
      fromJson: (json) => ResponseMessageModel.fromJson(json),
    );
  }

}