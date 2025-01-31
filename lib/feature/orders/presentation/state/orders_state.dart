import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_list_response_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_response_model.dart';

class OrderListState {
  final ResponseStateModel<DataPaginationModel<OrderListResponseModel>> response;
  bool loading = false;

  OrderListState({required this.response, this.loading = false});

  OrderListState.initial() : response = ResponseStateModel.initial();

  static OrderListState copyWith({
    required ResponseStateModel<DataPaginationModel<OrderListResponseModel>> response,
    bool? loading,
  }) {
    return OrderListState(
      response: response,
      loading: loading ?? false,
    );
  }
}

class OrderTransferVehicleState {
  final ResponseStateModel<OrderTransferVehicleResponseModel> response;
  bool loading = false;

  OrderTransferVehicleState({required this.response, this.loading = false});

  OrderTransferVehicleState.initial() : response = ResponseStateModel.initial();

  static OrderTransferVehicleState copyWith({
    required ResponseStateModel<OrderTransferVehicleResponseModel> response,
    bool? loading,
  }) {
    return OrderTransferVehicleState(
      response: response,
      loading: loading ?? false,
    );
  }
}
