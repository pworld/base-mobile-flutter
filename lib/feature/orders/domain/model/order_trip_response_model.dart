import 'package:app_management_system/shared/helper.dart';

class OrderTripResponseModel {
  final String dataId;
  final List<String> dataIds;

  OrderTripResponseModel({
    required this.dataId,
    required this.dataIds
  });

  factory OrderTripResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderTripResponseModel(
      dataId: TypeCaster.intoString(json['data_id']),
      dataIds: json['data_ids'],
    );
  }
}