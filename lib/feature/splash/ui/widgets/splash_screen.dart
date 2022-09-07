import 'package:boilerplate/feature/authentication/resource/user_repository.dart';
import 'package:boilerplate/feature/splash/cubit/startup_cubit.dart';
import 'package:boilerplate/feature/splash/resource/startup_repository.dart';
import 'package:boilerplate/feature/splash/ui/screens/splash_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartupCubit(
        startUpRepository: RepositoryProvider.of<StartUpRepository>(context),
        userRepository: RepositoryProvider.of<UserRepository>(context),
      )..fetchStartupData(),
      child: SplashWidget(),
    );
  }
}
