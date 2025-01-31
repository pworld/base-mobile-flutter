import 'package:app_management_system/core/authentication/auth_provider.dart';
import 'package:app_management_system/feature/orders/data/orders_source.dart';
import 'package:app_management_system/feature/orders/presentation/provider/order_detail_view_notifier.dart';
import 'package:app_management_system/feature/orders/presentation/provider/order_list_notifier.dart';
import 'package:app_management_system/feature/orders/presentation/provider/order_transfer_vehicle_notifier.dart';
import 'package:app_management_system/feature/orders/presentation/state/orders_detail_view_state.dart';
import 'package:app_management_system/feature/orders/presentation/state/orders_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ordersSourceProvider = Provider((ref) {
  final authController = ref.watch(authProvider);
  return OrdersDataSource(authController: authController);
});

final detailViewProvider = StateNotifierProvider.autoDispose<
    OrderDetailViewNotifier, OrderDetailViewState>(
  (ref) {
    return OrderDetailViewNotifier();
  },
);

final orderListProvider =
    StateNotifierProvider<OrderListNotifier, OrderListState>((ref) {
  return OrderListNotifier(ref.read(ordersSourceProvider));
});

final orderTransferVehicleProvider = StateNotifierProvider<
    OrderTransferVehicleNotifier, OrderTransferVehicleState>((ref) {
  return OrderTransferVehicleNotifier(ref.read(ordersSourceProvider));
});
