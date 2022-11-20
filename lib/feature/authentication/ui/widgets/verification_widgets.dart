import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/library/count_down/countdown_widget.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/date_utils.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/feature/authentication/cubit/email_verification_cubit.dart';
import 'package:aramex/feature/authentication/cubit/resend_otp_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationWidgets extends StatefulWidget {
  final String email;
  final int expiryDuration;
  const VerificationWidgets({
    Key? key,
    required this.email,
    required this.expiryDuration,
  }) : super(key: key);

  @override
  State<VerificationWidgets> createState() => _VerificationWidgetsState();
}

class _VerificationWidgetsState extends State<VerificationWidgets> {
  bool _isLoading = false;
  final ValueNotifier<int> _expiryDuration = ValueNotifier(0);

  final TextEditingController _otpController = TextEditingController();

  void _updateLoadingState(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

  @override
  void initState() {
    _expiryDuration.value = widget.expiryDuration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Center(
            child: CustomIconButton(
              icon: Icons.keyboard_arrow_left_rounded,
              onPressed: () {
                NavigationService.pop();
              },
            ),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<EmailVerificationCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  _updateLoadingState(true);
                } else {
                  _updateLoadingState(false);
                }

                if (state is CommonDataSuccessState) {
                  SnackBarUtils.showSuccessBar(
                    context: context,
                    message: "Email verified successfully",
                  );
                  NavigationService.pushNamedAndRemoveUntil(
                    routeName: Routes.login,
                  );
                } else if (state is CommonErrorState) {
                  SnackBarUtils.showErrorBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
            ),
            BlocListener<ResendOtpCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  _updateLoadingState(true);
                } else {
                  _updateLoadingState(false);
                }

                if (state is CommonDataSuccessState) {
                  SnackBarUtils.showSuccessBar(
                    context: context,
                    message: "OTP send successfully",
                  );
                  _expiryDuration.value = state.data ?? 0;
                } else if (state is CommonErrorState) {
                  SnackBarUtils.showErrorBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 54, bottom: 8),
                  child: Text(
                    LocaleKeys.verifyOTP.tr(),
                    style: _textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  LocaleKeys.pleaseEnter4DigitOTP.tr(),
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 48),
                PinCodeTextField(
                  length: 4,
                  appContext: context,
                  controller: _otpController,
                  animationType: AnimationType.fade,
                  cursorColor: CustomTheme.primaryColor,
                  mainAxisAlignment: MainAxisAlignment.start,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 58,
                    fieldWidth: 58,
                    fieldOuterPadding: const EdgeInsets.only(right: 24),
                    activeFillColor: Colors.white,
                    activeColor: CustomTheme.primaryColor,
                    inactiveColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: CustomTheme.primaryColor,
                  ),
                  enableActiveFill: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder<int>(
                    valueListenable: _expiryDuration,
                    builder: (context, expireDuration, _) {
                      return CountdownBuilder(
                        duration: Duration(seconds: expireDuration),
                        key: UniqueKey(),
                        builder: (context, duration) {
                          return RichText(
                            text: TextSpan(
                              text: LocaleKeys.didntReceiveAnyCode.tr() + "?",
                              style: _textTheme.headline6,
                              children: [
                                TextSpan(
                                  text:
                                      " ${LocaleKeys.resend.tr()} ${duration.inSeconds == 0 ? LocaleKeys.otp.tr().toUpperCase() : "in ${duration.formatedDuration}"}",
                                  style: _textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: CustomTheme.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      if (duration.inSeconds == 0) {
                                        context
                                            .read<ResendOtpCubit>()
                                            .resendOTPViaEmail(
                                              email: widget.email,
                                            );
                                      }
                                    },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                const Spacer(),
                CustomRoundedButtom(
                  title: LocaleKeys.verifyOTP.tr(),
                  onPressed: () {
                    final _validateMessage = FormValidator.validateOTP(
                      _otpController.text,
                      label: LocaleKeys.otp.tr(),
                    );
                    if (_validateMessage == null) {
                      context.read<EmailVerificationCubit>().verifyUsingEmail(
                            widget.email,
                            _otpController.text,
                          );
                    } else {
                      SnackBarUtils.showErrorBar(
                        context: context,
                        message: _validateMessage,
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
    );
  }
}
