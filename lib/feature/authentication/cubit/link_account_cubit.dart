import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkAccountCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  LinkAccountCubit({required this.userRepository})
      : super(CommonInitialState());

  linkAccount(String accountNumber, String verificationCode) async {
    emit(CommonLoadingState());
    final _res = await userRepository.linkAccount(
      accountNumber: accountNumber,
      pinCode: verificationCode,
    );
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to verify email"));
    }
  }
}
