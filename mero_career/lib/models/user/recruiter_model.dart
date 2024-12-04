class RecruiterProfile {
  String companyProfileImage;
  String companyName;
  String phoneNumber;
  String address;
  String companyType;
  String registrationNumber;
  String panNumber;
  String companySummary;
  bool isApproved;

  String email;
  String password;
  String role;

  RecruiterProfile({
    required this.companyProfileImage,
    required this.companyName,
    required this.phoneNumber,
    required this.address,
    required this.companyType,
    required this.registrationNumber,
    required this.panNumber,
    this.companySummary = '',
    this.isApproved = true,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'is_verified': false,
      'company_profile_image': companyProfileImage,
      'company_name': companyName,
      'phone_number': phoneNumber,
      'address': address,
      'company_type': companyType,
      'registration_number': registrationNumber,
      'pan_number': panNumber,
      'company_summary': companySummary,
      'is_approved': isApproved,
    };
  }

  factory RecruiterProfile.fromJson(Map<String, dynamic> json) {
    return RecruiterProfile(
      companyProfileImage: json['company_profile_image'],
      companyName: json['company_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      companyType: json['company_type'],
      registrationNumber: json['registration_number'],
      panNumber: json['pan_number'],
      companySummary: json['company_summary'] ?? '',
      isApproved: json['is_approved'] ?? true,
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }
}
