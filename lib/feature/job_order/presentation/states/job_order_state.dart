import 'package:app_management_system/feature/job_order/domain/model/job_order_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/services/response_message_model.dart';
import '../../../../shared/services/response_paginations_model.dart';
import '../../domain/model/transfer_vehicle_model.dart';

class JobOrdersListState {
  final AsyncValue <PaginationsModel<ResponseJobOrderList> > successData;

  JobOrdersListState({required this.successData});

  JobOrdersListState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}

class JobOrderState {
  final AsyncValue <ResponseJobOrderList > successData;

  JobOrderState({required this.successData});

  JobOrderState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}

class TransferVehicleState {
  final AsyncValue <ResponseTransferVehicleModel > successData;

  TransferVehicleState({required this.successData});

  TransferVehicleState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}

class TransferVehicleTripState {
  final AsyncValue <ResponseMessageModel > successData;

  TransferVehicleTripState({required this.successData});

  TransferVehicleTripState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}