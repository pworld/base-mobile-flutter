import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/widgets.dart';

// Enum Job Order Type
enum JobOrderType { transfer, order }

extension JobOrderTypeExt on JobOrderType {
  String get label {
    switch(this) {
      case JobOrderType.transfer:
        return 'Vehicle Transfer';
      case JobOrderType.order:
        return 'Customer Order';
      default:
        return 'Unknown';
    }
  }
}

// Enum Status Job Order

enum JobOrderTripType { start, finish }
enum JobOrderStatus { planned, ontrip, done, cancelled }

extension JobOrderStatusExt on JobOrderStatus {
  String get label {
    switch (this) {
      case JobOrderStatus.planned:
        return 'Planned';
      case JobOrderStatus.ontrip:
        return 'Dalam Perjalanan';
      case JobOrderStatus.done:
        return 'Selesai';
      case JobOrderStatus.cancelled:
        return 'Dibatalkan';
      default:
        return 'Unknown';
    }
  }
}

/// Convert string into an enum value of `JobOrderStatus`
/// ### Exception
/// Method will cause an exception if `status` does not exist in JobOrderStatus
JobOrderStatus intoJobOrderStatus(String status) {
  try {
    return JobOrderStatus.values.byName(status);
  }
  catch (e) {
    return JobOrderStatus.planned;
  }
}

/// Get color based on given `JobOrderStatus`
Color jobOrderStatusColor(JobOrderStatus status) {
  switch (status) {
    case JobOrderStatus.planned:
      return AppColors.kInfoColor;
    case JobOrderStatus.ontrip:
      return AppColors.kWarningColor;
    case JobOrderStatus.done:
      return AppColors.kSuccessColor;
    case JobOrderStatus.cancelled:
      return AppColors.kErrorColor;
    default:
      return AppColors.black;
  }
}

/// Get bg and text color based on given `JobOrderStatus`
(Color, Color) jobOrderStatusChipColor(JobOrderStatus status) {
  switch (status) {
    case JobOrderStatus.planned:
      return const (Color(0xFFBAE6FD), Color(0xFF0369A1));
    case JobOrderStatus.ontrip:
      return const (Color(0xFFFEF08A), Color(0xFFA16207));
    case JobOrderStatus.done:
      return const (Color(0xFFBBF7D0), Color(0xFF15803D));
    case JobOrderStatus.cancelled:
      return const (Color(0xFFBBF7D0), Color(0xFF15803D));
    default:
      return const (Color(0xFFFECACA), Color(0xFFB91C1C));
  }
}
