import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/common/widget/text_field/pin_textfield.dart';
import 'package:aramex/feature/authentication/cubit/link_account_cubit.dart';
import 'package:aramex/feature/authentication/ui/widgets/logout_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LinkAccountWidgets extends StatefulWidget {
  const LinkAccountWidgets({Key? key}) : super(key: key);

  @override
  State<LinkAccountWidgets> createState() => _LinkAccounttsState();
}

class _LinkAccounttsState extends State<LinkAccountWidgets> {
  bool _isLoading = false;
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                showLogoutDialog(context);
              },
            ),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<LinkAccountCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  _updateLoadingState(true);
                } else {
                  _updateLoadingState(false);
                }

                if (state is CommonDataSuccessState) {
                  SnackBarUtils.showSuccessBar(
                    context: context,
                    message: "Account Linked successfully",
                  );
                  NavigationService.pushNamedAndRemoveUntil(
                    routeName: Routes.dashboard,
                  );
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 54, bottom: 8),
                    child: Text(
                      LocaleKeys.linkAccount.tr(),
                      style: _textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    LocaleKeys.pleaseEnterAccountNumberAnd4DigitCode.tr(),
                    style: _textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    label: LocaleKeys.accountNumber.tr(),
                    hintText: "XXXXXXXXXX",
                    controller: _accountNumberController,
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                        value,
                        LocaleKeys.accountNumber.tr(),
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
                  const SizedBox(height: 24),
                  const Spacer(),
                  CustomRoundedButtom(
                    title: LocaleKeys.linkAccount.tr(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LinkAccountCubit>().linkAccount(
                              _accountNumberController.text,
                              _verificationCodeController.text,
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
    );
  }
}
