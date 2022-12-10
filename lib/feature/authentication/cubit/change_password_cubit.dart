import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:bloc/bloc.dart';

class ChangePasswordCubit extends Cubit<CommonState> {
  ChangePasswordCubit({required this.userRepository}) : super(CommonInitialState());

  UserRepository userRepository;

  changePassword(
      {required String newPassword, required String oldPassword}) async {
    emit(CommonLoadingState());
    final res = await userRepository.changePassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
  );
    if (res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(
        CommonErrorState(
            message: res.message ?? "Unable to change password",
            statusCode: res.statusCode),
      );
    }
  }
}
