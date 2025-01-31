import 'package:app_management_system/feature/orders/presentation/state/orders_detail_view_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderDetailViewNotifier extends StateNotifier<OrderDetailViewState> {
  OrderDetailViewNotifier() : super(const OrderDetailViewState(loading: false));

  void setState({bool? loading}) {
    state = state.copyWith(loading: loading);
  }
}
