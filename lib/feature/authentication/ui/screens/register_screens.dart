import 'package:aramex/feature/authentication/cubit/signup_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/register_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreens extends StatelessWidget {
  const RegisterScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const RegisterWidgets(),
    );
  }
}
