class ResponseMessageModel {
  final String? dataId;              // Single string data ID
  final List<String>? dataIds;       // List of string data IDs

  ResponseMessageModel({
    this.dataId,
    this.dataIds,
  });

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return ResponseMessageModel(
      dataId: json['data_id'] as String?,  // Parse single string data ID
      dataIds: json['data_ids'] != null    // Parse list of string data IDs
          ? List<String>.from(json['data_ids'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_id': dataId,             // Serialize single string data ID
      'data_ids': dataIds,           // Serialize list of string data IDs
    };
  }
}
