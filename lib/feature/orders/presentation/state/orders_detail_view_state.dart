import 'package:flutter/widgets.dart';

@immutable
class OrderDetailViewState {
  final bool loading;

  const OrderDetailViewState({required this.loading});

  OrderDetailViewState copyWith({
    bool? loading,
  }) {
    return OrderDetailViewState(
      loading: loading ?? this.loading,
    );
  }
}
