import 'package:aramex/feature/authentication/cubit/email_login_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreens extends StatelessWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailLoginCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const LoginWidgets(),
    );
  }
}
