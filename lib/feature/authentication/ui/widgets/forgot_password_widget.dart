import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/authentication/cubit/send_forgot_password_otp_cubit.dart';
import 'package:aramex/feature/authentication/ui/screens/set_reset_password_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ForgotPasswordWidgets extends StatefulWidget {
  const ForgotPasswordWidgets({super.key});

  @override
  State<ForgotPasswordWidgets> createState() => _ForgotPasswordWidgetsState();
}

class _ForgotPasswordWidgetsState extends State<ForgotPasswordWidgets> {
  final TextEditingController _emailController = TextEditingController();
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
        body: BlocListener<SendForgotPasswordOtpCubit, CommonState>(
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
                message: "Verification Code has been send to your email",
              );
              NavigationService.push(
                target: SetResetPasswordScreens(email: _emailController.text),
              );
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
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.aramex.tr().toLowerCase(),
                      style: _textTheme.headline1!.copyWith(
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                        color: CustomTheme.primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 48.hp, bottom: 8.hp),
                      child: Text(
                        LocaleKeys.forgotPassword.tr(),
                        style: _textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Text(
                      LocaleKeys.pleaseEnteryourEmailAddressToResetYourPassword
                          .tr(),
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 48.hp),
                    CustomTextField(
                      label: LocaleKeys.emailAddress.tr(),
                      hintText: "******@gmail.com",
                      controller: _emailController,
                      validator: (val) {
                        return FormValidator.validateEmail(val);
                      },
                    ),
                    CustomRoundedButtom(
                      title: LocaleKeys.sendEmail.tr(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<SendForgotPasswordOtpCubit>()
                              .sendForgotPasswordOtp(
                                email: _emailController.text,
                              );
                        }
                      },
                    ),
                    SizedBox(height: 24.hp),
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
