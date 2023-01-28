import 'dart:io';

import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SignupCubit({required this.userRepository}) : super(CommonInitialState());

  register({
    required File? profilePic,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final _res = await userRepository.register(
      profilePic: profilePic,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      password: password,
    );

    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState(data: _res.data));
    } else {
      emit(
        CommonErrorState(
          message: _res.message ?? "Unable to register",
          statusCode: _res.statusCode,
        ),
      );
    }
  }
}
