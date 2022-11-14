import 'package:aramex/common/constant/env.dart';
import 'package:aramex/feature/authentication/cubit/email_login_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiBlocWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmailLoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        )
      ],
      child: child,
    );
  }
}
