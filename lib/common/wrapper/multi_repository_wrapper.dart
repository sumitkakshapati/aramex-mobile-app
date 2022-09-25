import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/util/internet_check.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/splash/resource/startup_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiRepositoryWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(
          create: (context) => env,
          lazy: true,
        ),
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(),
          lazy: true,
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            env: RepositoryProvider.of<Env>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          )..initialState(),
          lazy: true,
        ),
        RepositoryProvider<StartUpRepository>(
          create: (context) => StartUpRepository(
            env: RepositoryProvider.of<Env>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
