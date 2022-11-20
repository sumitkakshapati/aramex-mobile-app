import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/authentication/cubit/signup_cubit.dart';
import 'package:aramex/feature/authentication/ui/screens/verification_screens.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterWidgets extends StatefulWidget {
  const RegisterWidgets({Key? key}) : super(key: key);

  @override
  State<RegisterWidgets> createState() => _RegisterWidgetsState();
}

class _RegisterWidgetsState extends State<RegisterWidgets> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _accountNumbercontroller =
      TextEditingController();
  final TextEditingController _fullNamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();

  bool _isLoading = false;

  void _updateLoadingState(bool status) {
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
        body: BlocListener<SignupCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              _updateLoadingState(true);
            } else {
              _updateLoadingState(false);
            }

            if (state is CommonDataSuccessState) {
              SnackBarUtils.showSuccessBar(
                context: context,
                message: "Registered successfully",
              );
              NavigationService.push(
                target: VerificationScreens(email: _emailcontroller.text),
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
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.registerToAramex.tr(),
                      style: _textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      LocaleKeys.weCoverAllKindOfTransportation.tr(),
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 48),
                      alignment: Alignment.center,
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        strokeWidth: 1,
                        dashPattern: const [6],
                        color: CustomTheme.primaryColor,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(42),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.image,
                            color: CustomTheme.primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(
                      label: LocaleKeys.accountNumber.tr(),
                      hintText: "12345678",
                      controller: _accountNumbercontroller,
                      isRequired: true,
                      validator: (val) {
                        return FormValidator.validateFieldNotEmpty(
                          val,
                          LocaleKeys.accountNumber.tr(),
                        );
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.fullName.tr(),
                      hintText: "Ram Shrestha",
                      controller: _fullNamecontroller,
                      isRequired: true,
                      validator: (val) {
                        return FormValidator.validateFieldNotEmpty(
                          val,
                          LocaleKeys.fullName.tr(),
                        );
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.email.tr(),
                      hintText: "******@gmail.com",
                      controller: _emailcontroller,
                      isRequired: true,
                      validator: (val) {
                        return FormValidator.validateEmail(val);
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.phoneNumber.tr(),
                      hintText: "98xxxxxxxx",
                      controller: _phoneNumbercontroller,
                      isRequired: true,
                      validator: (val) {
                        return FormValidator.validatePhoneNumber(val);
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.address.tr(),
                      hintText: "Enter Address",
                      controller: _addresscontroller,
                      isRequired: true,
                      validator: (val) {
                        return FormValidator.validateFieldNotEmpty(
                          val,
                          LocaleKeys.address.tr(),
                        );
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.password.tr(),
                      obscureText: true,
                      hintText: "******",
                      controller: _passwordcontroller,
                      isRequired: true,
                      validator: (val) {
                        return FormValidator.validateFieldNotEmpty(
                          val,
                          LocaleKeys.password.tr(),
                        );
                      },
                    ),
                    CustomTextField(
                      label: LocaleKeys.confirmPassword.tr(),
                      obscureText: true,
                      hintText: "******",
                      controller: _confirmPasswordcontroller,
                      isRequired: true,
                      bottomPadding: 24,
                      validator: (val) {
                        return FormValidator.validateConfirmPassword(
                          val,
                          _passwordcontroller.text,
                          label: LocaleKeys.confirmPassword.tr(),
                        );
                      },
                    ),
                    CustomRoundedButtom(
                      title: LocaleKeys.registerNow.tr(),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          context.read<SignupCubit>().register(
                                accountNumber: _accountNumbercontroller.text,
                                fullName: _fullNamecontroller.text,
                                email: _emailcontroller.text,
                                phoneNumber: _phoneNumbercontroller.text,
                                address: _addresscontroller.text,
                                password: _passwordcontroller.text,
                              );
                        }
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom + 20),
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
