class JobSeekerProfile {
  String fullName;
  String username;
  String email;
  String phoneNumber;
  String address;
  String password;
  int jobPreference;
  String role;
  bool isVerified;

  JobSeekerProfile({
    required this.fullName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.jobPreference,
    required this.role,
    required this.isVerified,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'is_verified': isVerified,
      'full_name': fullName,
      'username': username,
      'phone_number': phoneNumber,
      'address': address,
      'job_preference': jobPreference,
    };
  }

  factory JobSeekerProfile.fromJson(Map<String, dynamic> json) {
    return JobSeekerProfile(
      fullName: json['full_name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      password: json['password'],
      jobPreference: json['job_preference'],
      role: json['role'],
      isVerified: json['is_verified'],
    );
  }
}
