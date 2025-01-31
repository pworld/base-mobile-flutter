import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/services/request_paginations_model.dart';
import '../../../../shared/services/response_message_model.dart';
import '../../data_access/usecases/job_order_usecase.dart';
import '../../domain/model/transfer_vehicle_model.dart';
import 'job_order_state.dart';

class JobOrderNewStateNotifier extends StateNotifier<JobOrdersListState> {
  final JobOrderNewUseCase _jobOrderNewUseCase;

  JobOrderNewStateNotifier(this._jobOrderNewUseCase) : super(JobOrdersListState.initial());

  Future<void> jobOrderNew(RequestPage  requestData) async {
    state = JobOrdersListState(successData: const AsyncValue.loading());
    final response = await _jobOrderNewUseCase.jobOrders(requestData);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = JobOrdersListState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = JobOrdersListState(successData: AsyncValue.data(success));
      },
    );
  }
}

class transferVehicleStateNotifier extends StateNotifier<TransferVehicleState> {
  final JobOrderNewUseCase _jobOrderNewUseCase;

  transferVehicleStateNotifier(this._jobOrderNewUseCase) : super(TransferVehicleState.initial());

  void startLoading() {
    state = TransferVehicleState(successData: const AsyncValue.loading());
  }

  Future<void> fetchJobOrderTransferVehicle(String  jobOrderId) async {
    final response = await _jobOrderNewUseCase.fetchJobOrderTransferVehicle(jobOrderId);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = TransferVehicleState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = TransferVehicleState(successData: AsyncValue.data(success));
      },
    );
  }
}

class updateTransferVehicleStateNotifier extends StateNotifier<TransferVehicleTripState> {
  final JobOrderNewUseCase _jobOrderNewUseCase;

  updateTransferVehicleStateNotifier(this._jobOrderNewUseCase) : super(TransferVehicleTripState.initial());

  void startLoading() {
    state = TransferVehicleTripState(successData: const AsyncValue.loading());
  }

  Future<TransferVehicleTripState> updateTransferVehicle(RequestTransferVehicleTripModel payload) async {

    final response = await _jobOrderNewUseCase.jobOrderTransferVehicleStartTrip(payload);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = TransferVehicleTripState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = TransferVehicleTripState(successData: AsyncValue.data(success));
      },
    );
    return state;
  }

  Future<TransferVehicleTripState> startTransferVehicle(RequestTransferVehicleTripModel payload) async {

    final response = await _jobOrderNewUseCase.jobOrderTransferVehicleStartTrip(payload);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = TransferVehicleTripState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = TransferVehicleTripState(successData: AsyncValue.data(success));
      },
    );
    return state;
  }

  Future<TransferVehicleTripState> finishTransferVehicle(RequestTransferVehicleTripModel payload) async {

    final response = await _jobOrderNewUseCase.jobOrderTransferVehicleFinishTrip(payload);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = TransferVehicleTripState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = TransferVehicleTripState(successData: AsyncValue.data(success));
      },
    );
    return state;
  }
}