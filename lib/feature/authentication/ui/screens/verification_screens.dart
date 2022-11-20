import 'package:aramex/feature/authentication/cubit/email_verification_cubit.dart';
import 'package:aramex/feature/authentication/cubit/resend_otp_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/verification_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreens extends StatelessWidget {
  final String email;
  final int expiryDuration;
  const VerificationScreens({
    Key? key,
    required this.email,
    this.expiryDuration = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmailVerificationCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ResendOtpCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
      ],
      child: VerificationWidgets(
        email: email,
        expiryDuration: expiryDuration,
      ),
    );
  }
}
