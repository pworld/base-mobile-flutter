import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/feature/orders/data/orders_source.dart';
import 'package:app_management_system/feature/orders/domain/model/order_list_response_model.dart';
import 'package:app_management_system/feature/orders/presentation/state/orders_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderListNotifier extends StateNotifier<OrderListState> {
  final OrdersDataSource source;

  OrderListNotifier(this.source) : super(OrderListState.initial());

  Future<void> fetch(
    bool refresh,
    HTTPPaginationPayloadModel payload,
  ) async {
    final response = await source.getJobOrderList(
      payload,
      () => {},
    );

    if (response.errorMessage != null) {

      return;      
    }

    if (refresh) {
      state = OrderListState(response: response);
    } else {
      OrderListPaginationResponseModel r = response.data!;
      r.data.addAll(response.data?.data ?? List.empty());
      state = OrderListState.copyWith(response: response.copyWith(data: r));
    }
  }

  List<OrderListResponseModel> getList() {
    if (state.response.status == HTTPStatus.initial) {
      return List.empty();
    }

    if (state.response.data?.data == null) {
      return List.empty();
    }

    return state.response.data!.data;
  }

  void reset() {
    state = OrderListState.initial();
  }
}
