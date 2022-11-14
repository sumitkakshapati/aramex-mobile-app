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

  Future<dynamic> fetchProfile({required String token}) async {
    return await apiProvider.get('$baseUrl/user/profile', token: token);
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
}
