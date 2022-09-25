import 'package:bloc/bloc.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/model/user.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'social_login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit({required this.userRepository})
      : super(SocialLoginInitial());

  UserRepository userRepository;

  loginWithGoogle() async {
    emit(SocialLoginLoading());
    final res = await userRepository.signInGoogle();
    if (res.status == Status.Success && res.data != null) {
      emit(SocialLoginSuccess(user: res.data!));
    } else {
      emit(SocialLoginError(
          message: res.message ?? LocaleKeys.unableToLogin.tr()));
    }
  }

  loginWithFacebook() async {
    emit(SocialLoginLoading());
    final res = await userRepository.signInFacebook();
    if (res.status == Status.Success && res.data != null) {
      emit(SocialLoginSuccess(user: res.data!));
    } else {
      emit(SocialLoginError(
          message: res.message ?? LocaleKeys.unableToLogin.tr()));
    }
  }
}
