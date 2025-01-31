class ProfileModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? email;  // Made nullable
  final String? vehicleType;
  final String? vehicleRegNo;

  // Additional fields (optional)
  final String? driverId;
  final String? tenantId;
  final String? fullName;
  final String? placeOfBirth;
  final DateTime? dateOfBirth;
  final String? sex;
  final String? profilePicturePath;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,  // Nullable
    required this.vehicleType,
    required this.vehicleRegNo,
    this.driverId,
    this.tenantId,
    this.fullName,
    this.placeOfBirth,
    this.dateOfBirth,
    this.sex,
    this.profilePicturePath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String?,
      vehicleType: json['vehicle_type_name'] as String?,  // Changed to match JSON key
      vehicleRegNo: json['vehicle_plate_number'] as String?,  // Changed to match JSON key
      driverId: json['driver_id'] as String?,
      tenantId: json['tenant_id'] as String?,
      fullName: json['full_name'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      dateOfBirth: json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null,
      sex: json['sex'] as String?,
      profilePicturePath: json['profile_picture_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'vehicle_type_name': vehicleType,
      'vehicle_plate_number': vehicleRegNo,
      'driver_id': driverId,
      'tenant_id': tenantId,
      'full_name': fullName,
      'place_of_birth': placeOfBirth,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'sex': sex,
      'profile_picture_path': profilePicturePath,
    };
  }
}
