import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/authentication/cubit/change_password_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ChangePasswordWidgets extends StatefulWidget {
  const ChangePasswordWidgets({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidgets> createState() => _ChangePasswordWidgetsState();
}

class _ChangePasswordWidgetsState extends State<ChangePasswordWidgets> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocListener<ChangePasswordCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              _updateLoadingState(true);
            } else {
              _updateLoadingState(false);
            }

            if (state is CommonDataSuccessState) {
              SnackBarUtils.showSuccessBar(
                context: context,
                message: "Password Changed Successfully",
              );
              NavigationService.pop();
            } else if (state is CommonErrorState) {
              SnackBarUtils.showErrorBar(
                context: context,
                message: state.message,
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Container(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 56.hp),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.changePassword.tr(),
                            style: _textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.hp),
                          Text(
                            LocaleKeys.youCanChangeAppPasswordFromHere.tr(),
                            style: _textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 48.hp),
                          CustomTextField(
                            label: LocaleKeys.currentPassword.tr(),
                            hintText: LocaleKeys.enterCurrentPassword.tr(),
                            controller: _currentPasswordController,
                            validator: (val) {
                              return FormValidator.validatePassword(
                                val,
                                label: LocaleKeys.currentPassword.tr(),
                              );
                            },
                          ),
                          CustomTextField(
                            label: LocaleKeys.newPassword.tr(),
                            hintText: LocaleKeys.enterNewPassword.tr(),
                            controller: _newPasswordController,
                            validator: (val) {
                              return FormValidator.validatePassword(
                                val,
                                label: LocaleKeys.newPassword.tr(),
                              );
                            },
                          ),
                          CustomTextField(
                            label: LocaleKeys.confirmPassword.tr(),
                            hintText: LocaleKeys.enterConfirmPassword.tr(),
                            controller: _confirmPasswordController,
                            validator: (val) {
                              return FormValidator.validateConfirmPassword(
                                val,
                                _newPasswordController.text,
                                label: LocaleKeys.confirmPassword.tr(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomOutlineButton(
                                  title: LocaleKeys.cancel.tr(),
                                  onPressed: () {
                                    NavigationService.pop();
                                  },
                                ),
                              ),
                              SizedBox(width: 20.wp),
                              Expanded(
                                child: CustomRoundedButtom(
                                  title: LocaleKeys.confirmChange.tr(),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<ChangePasswordCubit>()
                                          .changePassword(
                                            newPassword:
                                                _newPasswordController.text,
                                            oldPassword:
                                                _currentPasswordController.text,
                                          );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SafeArea(child: SizedBox(height: 20.hp)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
