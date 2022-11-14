part of 'email_login_cubit.dart';

abstract class EmailLoginState extends Equatable {
  const EmailLoginState();

  @override
  List<Object> get props => [];
}

class EmailLoginInitial extends EmailLoginState {}

class EmailLoginLoading extends EmailLoginState {}

class EmailLoginSuccess extends EmailLoginState {
  final User user;

  const EmailLoginSuccess({required this.user});
}

class EmailLoginError extends EmailLoginState {
  final String message;

  const EmailLoginError({required this.message});
}
