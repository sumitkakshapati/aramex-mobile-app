import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  EmailVerificationCubit({required this.userRepository})
      : super(CommonInitialState());

  verifyUsingEmail(String email, String otpCode) async {
    emit(CommonLoadingState());
    final _res =
        await userRepository.verifyUsingEmail(email: email, otpCode: otpCode);
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to verify email"));
    }
  }
}
