import 'package:aramex/common/enum/environment.dart';

class Env {
  Env({
    required this.baseUrl,
    required this.imageUrl,
    required this.appEnvironment,
  });

  final String baseUrl;
  final String imageUrl;
  final AppEnvironment appEnvironment;
}

class EnvValue {
  static final Env development = Env(
    baseUrl: 'http://127.0.0.1:8848/api',
    imageUrl: 'http://127.0.0.1:8848/api',
    appEnvironment: AppEnvironment.Development,
  );

  static final Env staging = Env(
    baseUrl: 'http://15.207.84.87:8848/api',
    imageUrl: 'http://15.207.84.87:8848/api',
    appEnvironment: AppEnvironment.Stage,
  );

  static final Env production = Env(
    baseUrl: 'http://15.207.84.87:8848/api',
    imageUrl: 'http://15.207.84.87:8848/api',
    appEnvironment: AppEnvironment.Production,
  );
}
