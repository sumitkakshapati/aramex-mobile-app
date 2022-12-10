import 'package:aramex/common/http/api_provider.dart';

class AuthApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  const AuthApiProvider({
    required this.apiProvider,
    required this.baseUrl,
  });

  Future<dynamic> emailLogin(
      {required String email, required String password}) async {
    final Map<String, dynamic> body = {'email': email, 'password': password};
    return await apiProvider.post('$baseUrl/auth/login', body);
  }

  Future<dynamic> register({
    required String accountNumber,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
  }) async {
    final Map<String, dynamic> body = {
      "full_name": fullName,
      "email": email,
      "phone": phoneNumber,
      "account_number": accountNumber,
      "password": password,
      "address": address,
    };
    return await apiProvider.post('$baseUrl/auth/register', body);
  }

  Future<dynamic> fetchProfile({required String token}) async {
    return await apiProvider.get('$baseUrl/auth/profile', token: token);
  }

  Future<dynamic> sendNotificationToken(
      {required String notificationToken, required String token}) async {
    final param = {"token": notificationToken};
    return await apiProvider.post(
      '$baseUrl/auth/firebase',
      param,
      token: token,
    );
  }

  Future<dynamic> verifyUsingEmail(
      {required String email, required String otpCode}) async {
    final Map<String, dynamic> body = {
      "email": email,
      "token": otpCode,
    };
    return await apiProvider.post('$baseUrl/auth/verify-email', body);
  }

  Future<dynamic> resendOTPViaEmail({required String email}) async {
    final Map<String, dynamic> body = { 
      "email": email,
    };
    return await apiProvider.post(
      '$baseUrl/auth/send-token?type=email-verification',
      body,
    );
  }

  Future<dynamic> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String token}) async {
    final Map<String, dynamic> body = {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
    return await apiProvider.post(
      '$baseUrl/auth/me/change-password',
      body,
      token: token,
    );
  }
}
