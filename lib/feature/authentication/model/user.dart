class User {
  //"_id", "full_name", "email", "email_verified", "phone", "email_verified", "account_number", "address", "status"
  int id;
  String fullname;
  String email;
  bool isEmailVerified;
  String phone;
  bool isPhoneVerified;
  String accountNumber;
  String address;
  String status;

  User({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.accountNumber,
    required this.address,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullname: json['full_name'] ?? "",
      email: json['email'],
      isEmailVerified: json['email_verified'] ?? false,
      phone: json['phone'],
      isPhoneVerified: json['phone_verified'] ?? false,
      accountNumber: json['account_number'],
      address: json['address'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['full_name'] = fullname;
    data['email'] = email;
    data['email_verified'] = isEmailVerified;
    data['phone'] = phone;
    data['phone_verified'] = isPhoneVerified;
    data['account_number'] = accountNumber;
    data['address'] = address;
    data['status'] = status;

    return data;
  }
}
