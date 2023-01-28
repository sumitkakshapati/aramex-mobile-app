import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/device_utils.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/authentication/cubit/email_login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  _updateLoadingState(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: BlocListener<EmailLoginCubit, EmailLoginState>(
        listener: (context, state) {
          if (state is EmailLoginLoading) {
            _updateLoadingState(true);
          } else {
            _updateLoadingState(false);
          }

          if (state is EmailLoginSuccess) {
            SnackBarUtils.showSuccessBar(
              context: context,
              message: "Logged in successfully",
            );
            if (state.user.accountNumber.isNotEmpty) {
              NavigationService.pushNamedAndRemoveUntil(
                routeName: Routes.dashboard,
              );
            } else {
              NavigationService.pushNamedAndRemoveUntil(
                routeName: Routes.linkAccount,
              );
            }
          } else if (state is EmailLoginError) {
            SnackBarUtils.showErrorBar(
              context: context,
              message: state.message,
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).viewPadding.top + 40.hp),
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
                        LocaleKeys.loginToAramex.tr(),
                        style: _textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Text(
                      LocaleKeys.weCoverAllKindOfTransportation.tr(),
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
                    CustomTextField(
                      label: LocaleKeys.password.tr(),
                      hintText: "********",
                      obscureText: true,
                      controller: _passwordController,
                      validator: (val) {
                        return FormValidator.validatePassword(val);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${LocaleKeys.forgotPassword.tr()}?",
                        style: _textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.hp),
                    CustomRoundedButtom(
                      title: LocaleKeys.login.tr(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<EmailLoginCubit>().loginWithEmail(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      },
                    ),
                    SizedBox(height: 24.hp),
                    RichText(
                      text: TextSpan(
                        text: "${LocaleKeys.dontHaveAnAccount.tr()}",
                        style: _textTheme.headline6,
                        children: [
                          TextSpan(
                            text: " ${LocaleKeys.registerNow.tr()}",
                            style: _textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomTheme.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                NavigationService.pushNamed(
                                    routeName: Routes.registration);
                              },
                          ),
                        ],
                      ),
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
