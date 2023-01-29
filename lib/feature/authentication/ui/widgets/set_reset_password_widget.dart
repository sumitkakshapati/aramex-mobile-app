// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/common/widget/text_field/pin_textfield.dart';
import 'package:aramex/feature/authentication/cubit/set_forgot_password_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SetResetPasswordWidgets extends StatefulWidget {
  final String email;
  const SetResetPasswordWidgets({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<SetResetPasswordWidgets> createState() =>
      _SetResetPasswordWidgetsState();
}

class _SetResetPasswordWidgetsState extends State<SetResetPasswordWidgets> {
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocListener<SetForgotPasswordCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }

            if (state is CommonDataSuccessState) {
              SnackBarUtils.showSuccessBar(
                context: context,
                message: "Password reset successfully!!",
              );
              NavigationService.pushNamedAndRemoveUntil(routeName: Routes.login);
            } else if (state is CommonErrorState) {
              SnackBarUtils.showErrorBar(
                context: context,
                message: state.message,
              );
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        LocaleKeys.setPassword.tr(),
                        style: _textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      LocaleKeys.pleaseEnterNewPassword.tr(),
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 48),
                    CustomTextField(
                      label: LocaleKeys.newPassword.tr(),
                      hintText: LocaleKeys.newPassword.tr(),
                      controller: _newPasswordController,
                      obscureText: true,
                      validator: (value) {
                        return FormValidator.validatePassword(value);
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.confirmPassword.tr(),
                      hintText: LocaleKeys.confirmPassword.tr(),
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        return FormValidator.validateConfirmPassword(
                          value,
                          _newPasswordController.text,
                        );
                      },
                    ),
                    Text(
                      LocaleKeys.verificationCode.tr(),
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomPinTextField(
                      controller: _verificationCodeController,
                    ),
                    SizedBox(height: 24.hp),
                    CustomRoundedButtom(
                      title: LocaleKeys.setPassword.tr().toUpperCase(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<SetForgotPasswordCubit>()
                              .setForgotPassword(
                                email: widget.email,
                                password: _newPasswordController.text,
                                token: _verificationCodeController.text,
                              );
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.bottom > 0
                          ? MediaQuery.of(context).viewPadding.bottom + 10
                          : 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
