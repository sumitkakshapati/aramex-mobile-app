import 'package:aramex/feature/authentication/cubit/change_password_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/change_password_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreens extends StatelessWidget {
  const ChangePasswordScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const ChangePasswordWidgets(),
    );
  }
}
