import 'package:app_management_system/feature/orders/data/orders_source.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_response_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_trip_payload_model.dart';
import 'package:app_management_system/feature/orders/presentation/state/orders_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderTransferVehicleNotifier
    extends StateNotifier<OrderTransferVehicleState> {
  final OrdersDataSource source;

  OrderTransferVehicleNotifier(this.source)
      : super(OrderTransferVehicleState.initial());

  Future<void> fetch(String id) async {
    final response = await source.getOrderTransferVehicle(
      id,
      () => {},
    );

    if (response.errorMessage != null) {
      throw response.errorMessage!;
      // return;
    }

    state = OrderTransferVehicleState(response: response);
  }

  Future<void> startTrip(
    String id,
    OrderTransferVehicleTripPayloadModel payload,
    Function() onSucces,
    Function(String message) onError,
  ) async {
    final response = await source.startTrip(
      id,
      payload,
      () => {},
    );

    if (response.errorMessage != null) {
      return onError(response.errorMessage!);
    }

    onSucces();
  }

  Future<void> finishTrip(
    String id,
    OrderTransferVehicleTripPayloadModel payload,
    Function() onSucces,
    Function(String message) onError,
  ) async {
    final response = await source.finishTrip(
      id,
      payload,
      () => {},
    );

    if (response.errorMessage != null) {
      return onError(response.errorMessage!);
    }

    onSucces();
  }

  OrderTransferVehicleResponseModel? getData() {
    return state.response.data;
  }

  void reset() {
    state = OrderTransferVehicleState.initial();
  }
}
