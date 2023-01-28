import 'dart:io';

import 'package:aramex/common/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' as parse;

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
    required File? profilePic,
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
      "profile_pic": profilePic,
      "password": password,
      "address": address,
    };

    if (profilePic != null) {
      final String fileName = profilePic.path.split('/').last;
      body["profile_pic"] = await MultipartFile.fromFile(
        profilePic.path,
        filename: fileName,
        contentType: parse.MediaType('image', profilePic.path.split('.').last),
      );
    }

    return await apiProvider.post(
      '$baseUrl/auth/register',
      FormData.fromMap(body),
    );
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

  Future<dynamic> linkAccount({
    required String accountNumber,
    required String pinCode,
    required String token,
  }) async {
    final Map<String, dynamic> body = {
      "account_number": accountNumber,
      "pin": pinCode,
    };
    return await apiProvider.post(
      '$baseUrl/auth/link-account',
      body,
      token: token,
    );
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
