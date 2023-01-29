import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetForgotPasswordCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SetForgotPasswordCubit({required this.userRepository})
      : super(CommonInitialState());

  setForgotPassword({
    required String email,
    required String password,
    required String token,
  }) async {
    emit(CommonLoadingState());
    final _res = await userRepository.setForgotPassword(
      email: email,
      token: token,
      password: password,
    );
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(
        CommonErrorState(
          message: _res.message ?? "Unable to set new password!!",
        ),
      );
    }
  }
}
