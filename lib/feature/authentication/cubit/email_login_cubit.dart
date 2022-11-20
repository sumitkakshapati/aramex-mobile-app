import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/model/user.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'email_login_state.dart';

class EmailLoginCubit extends Cubit<EmailLoginState> {
  EmailLoginCubit({required this.userRepository}) : super(EmailLoginInitial());

  UserRepository userRepository;

  loginWithEmail({required String email, required String password}) async {
    emit(EmailLoginLoading());
    final res =
        await userRepository.signInWithEmail(email: email, password: password);
    if (res.status == Status.Success && res.data != null) {
      emit(EmailLoginSuccess(user: res.data!));
    } else {
      emit(
        EmailLoginError(
          message: res.message ?? LocaleKeys.unableToLogin.tr(),
          statusCode: res.statusCode,
        ),
      );
    }
  }
}
