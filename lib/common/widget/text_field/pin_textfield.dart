import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinTextField extends StatelessWidget {
  final TextEditingController? controller;
  const CustomPinTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              bodySmall: _textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
        errorColor: Colors.red,
      ),
      child: PinCodeTextField(
        length: 4,
        appContext: context,
        controller: controller,
        animationType: AnimationType.fade,
        cursorColor: CustomTheme.primaryColor,
        mainAxisAlignment: MainAxisAlignment.start,
        validator: (value) {
          return FormValidator.validateOTP(value);
        },
        autovalidateMode: AutovalidateMode.disabled,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
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
          errorBorderColor: Colors.red,
        ),
        errorTextSpace: 24,
        enableActiveFill: true,
        onChanged: (value) {},
      ),
    );
  }
}
