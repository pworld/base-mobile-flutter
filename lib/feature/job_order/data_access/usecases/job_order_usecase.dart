import 'package:app_management_system/core/services/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_management_system/feature/job_order/domain/model/job_order_model.dart';

import '../../../../shared/services/request_paginations_model.dart';
import '../../../../shared/services/response_message_model.dart';
import '../../../../shared/services/response_paginations_model.dart';
import '../../domain/model/transfer_vehicle_model.dart';
import '../services/job_order_service.dart';

class JobOrderNewUseCase {
  final JobOrderNewServices _jobOrderNewServices;

  JobOrderNewUseCase(this._jobOrderNewServices);

  Future<Either<Failure, PaginationsModel<ResponseJobOrderList>>> jobOrders(RequestPage payload) async {
    return await _jobOrderNewServices.fetchJobOrders(payload);
  }

  Future<Either<Failure, ResponseTransferVehicleModel>> fetchJobOrderHistories(String jobOrderId) async {
    return await _jobOrderNewServices.fetchJobOrderTransferVehicle(jobOrderId);
  }

  Future<Either<Failure, ResponseTransferVehicleModel>> fetchJobOrderTransferVehicle(String jobOrderId) async {
    return await _jobOrderNewServices.fetchJobOrderTransferVehicle(jobOrderId);
  }

  Future<Either<Failure, ResponseMessageModel>> jobOrderTransferVehicleStartTrip(RequestTransferVehicleTripModel payload) async {
    return await _jobOrderNewServices.jobOrderTransferVehicleStartTrip(payload);
  }

  Future<Either<Failure, ResponseMessageModel>> jobOrderTransferVehicleFinishTrip(RequestTransferVehicleTripModel payload) async {
    return await _jobOrderNewServices.jobOrderTransferVehicleFinishTrip(payload);
  }
}