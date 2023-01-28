import 'package:aramex/feature/authentication/cubit/link_account_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/authentication/ui/widgets/link_account_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkAccountScreens extends StatelessWidget {
  const LinkAccountScreens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LinkAccountCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
      ],
      child: const LinkAccountWidgets(),
    );
  }
}
