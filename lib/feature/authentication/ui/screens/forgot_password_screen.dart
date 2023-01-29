import 'package:aramex/feature/authentication/cubit/send_forgot_password_otp_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/forgot_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendForgotPasswordOtpCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const ForgotPasswordWidgets(),
    );
  }
}
