import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendForgotPasswordOtpCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SendForgotPasswordOtpCubit({required this.userRepository})
      : super(CommonInitialState());

  sendForgotPasswordOtp({required String email}) async {
    emit(CommonLoadingState());
    final _res = await userRepository.sendForgotPasswordEmail(email: email);
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to send verification code"));
    }
  }
}
