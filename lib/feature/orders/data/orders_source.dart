import 'package:app_management_system/core/authentication/auth_controller.dart';
import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/core/http/http_service.dart';
import 'package:app_management_system/feature/orders/domain/model/order_list_response_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_response_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_trip_payload_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_trip_response_model.dart';

typedef AsyncHTTPResponseModel<T> = Future<ResponseStateModel<T>>;
typedef OrderListPaginationResponseModel
    = DataPaginationModel<OrderListResponseModel>;

class OrdersDataSource extends HTTPService {
  final AuthController authController;

  OrdersDataSource({required this.authController});

  AsyncHTTPResponseModel<OrderListPaginationResponseModel> getJobOrderList(
    HTTPPaginationPayloadModel payload,
    Function() onSessionExpired,
  ) async {
    return request<OrderListPaginationResponseModel>(
      method: HTTPMethod.post,
      path: 'job-orders',
      payload: payload.toJson(),
      authController: authController,
      fromJson: (json) {
        var dp = DataPaginationModel.fromJson(
          json,
          (json) {
            var o = OrderListResponseModel.fromJson(json);
            return o;
          },
        );

        return dp;
      },
      onSessionExpired: onSessionExpired,
    );
  }

  AsyncHTTPResponseModel<OrderTransferVehicleResponseModel> getOrderTransferVehicle(
    String id,
    Function() onSessionExpired,
  ) async {
    return request<OrderTransferVehicleResponseModel>(
      method: HTTPMethod.get,
      path: 'job-order-vehicle-transfers/$id',
      authController: authController,
      fromJson: OrderTransferVehicleResponseModel.fromJson,
      onSessionExpired: onSessionExpired,
    );
  }

  AsyncHTTPResponseModel<OrderTripResponseModel> startTrip(
    String id,
    OrderTransferVehicleTripPayloadModel payload,
    Function() onSessionExpired,
  ) async {
    return request<OrderTripResponseModel>(
      method: HTTPMethod.put,
      path: 'job-order-vehicle-transfers/$id/start-trip',
      payload: payload.toJson(),
      authController: authController,
      fromJson: OrderTripResponseModel.fromJson,
      onSessionExpired: onSessionExpired,
    );
  }

  AsyncHTTPResponseModel<OrderTripResponseModel> finishTrip(
    String id,
    OrderTransferVehicleTripPayloadModel payload,
    Function() onSessionExpired,
  ) async {
    return request<OrderTripResponseModel>(
      method: HTTPMethod.put,
      path: 'job-order-vehicle-transfers/$id/finish-trip',
      payload: payload.toJson(),
      authController: authController,
      fromJson: OrderTripResponseModel.fromJson,
      onSessionExpired: onSessionExpired,
    );
  }
}
