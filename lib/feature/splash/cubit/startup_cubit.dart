import 'package:aramex/common/shared_pref/shared_pref.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/splash/resource/startup_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit({required this.startUpRepository, required this.userRepository})
      : super(StartupInitial());

  final StartUpRepository startUpRepository;
  final UserRepository userRepository;

  fetchStartupData() async {
    emit(StartupLoading());
    final isFirstTime = await SharedPref.getFirstTimeAppOpen();
    final _ = await startUpRepository.fetchConfig();
    await userRepository.initialState();
    await Future.delayed(const Duration(seconds: 2));
    emit(StartupSuccess(
      isFirstTime: isFirstTime,
      isLogged: userRepository.isLoggedIn.value,
    ));
  }
}
