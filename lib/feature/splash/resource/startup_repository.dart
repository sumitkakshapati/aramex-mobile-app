import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/http/custom_exception.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/splash/model/config.dart';
import 'package:aramex/feature/splash/resource/startup_api_provider.dart';
import 'package:flutter/material.dart';

class StartUpRepository {
  ApiProvider apiProvider;
  late StartUpApiProvider startupApiProvider;
  UserRepository userRepository;
  Env env;

  StartUpRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
  }) {
    startupApiProvider = StartUpApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  final ValueNotifier<Config> _config = ValueNotifier(Config.initial());

  ValueNotifier<Config> get config => _config;

  Future<DataResponse<Config>> fetchConfig() async {
    try {
      final _res = await startupApiProvider.fetchConfig();
      final _item =
          Config.fromJson(Map<String, dynamic>.from(_res["data"]["results"]));
      _config.value = _item;
      return DataResponse.success(_item);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
