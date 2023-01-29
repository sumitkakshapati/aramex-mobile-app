import 'package:aramex/feature/authentication/cubit/set_forgot_password_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/set_reset_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetResetPasswordScreens extends StatelessWidget {
  final String email;
  const SetResetPasswordScreens({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetForgotPasswordCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: SetResetPasswordWidgets(email: email),
    );
  }
}
