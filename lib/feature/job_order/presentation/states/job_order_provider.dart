import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data_access/services/job_order_service.dart';
import '../../data_access/usecases/job_order_usecase.dart';
import 'job_order_notifier.dart';
import 'job_order_state.dart';


// JobOrderNew Provider
final jobOrderNewServicesProvider = Provider<JobOrderNewServices>((ref) {
  return JobOrderNewServices();
});

final jobOrderNewUseCaseProvider = Provider<JobOrderNewUseCase>((ref) {
  final jobOrderNewServices = ref.read(jobOrderNewServicesProvider);
  return JobOrderNewUseCase(jobOrderNewServices);
});

final jobOrderNewStateNotifierProvider = StateNotifierProvider<JobOrderNewStateNotifier, JobOrdersListState>((ref) {
  final jobOrderNewUseCase = ref.read(jobOrderNewUseCaseProvider);
  return JobOrderNewStateNotifier(jobOrderNewUseCase);
});

final jobOrderTransferVehicleStateNotifierProvider = StateNotifierProvider<transferVehicleStateNotifier, TransferVehicleState>((ref) {
  final jobOrderNewUseCase = ref.read(jobOrderNewUseCaseProvider);
  return transferVehicleStateNotifier(jobOrderNewUseCase);
});

final transferVehicleStateNotifierProvider = StateNotifierProvider<updateTransferVehicleStateNotifier, TransferVehicleTripState>((ref) {
  final jobOrderNewUseCase = ref.read(jobOrderNewUseCaseProvider);
  return updateTransferVehicleStateNotifier(jobOrderNewUseCase);
});