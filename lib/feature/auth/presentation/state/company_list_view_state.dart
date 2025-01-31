import 'package:flutter/widgets.dart';

@immutable
class CompanyListViewState {
  final bool loading;

  const CompanyListViewState({required this.loading});

  CompanyListViewState copyWith({bool? loading}) {
    return CompanyListViewState(loading: loading ?? this.loading);
  }
}
