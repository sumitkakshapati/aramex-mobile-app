import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendOtpCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  ResendOtpCubit({required this.userRepository}) : super(CommonInitialState());

  resendOTPViaEmail({required String email}) async {
    emit(CommonLoadingState());
    final _res = await userRepository.resentOtpViaEmail(email: email);
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState(data: _res.data));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to resend OTP"));
    }
  }
}
