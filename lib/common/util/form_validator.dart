import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/text_utils.dart';
import 'package:easy_localization/easy_localization.dart';

class FormValidator {
  static String? validateEmail(String? val, [bool supportEmpty = false]) {
    if (supportEmpty && (val == null || val.isEmpty)) {
      return null;
    } else if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.email.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.email.tr()]);
    } else if (TextUtils.validateEmail(val)) {
      return null;
    } else {
      return LocaleKeys.pleaseEnterValidField.tr(args: [LocaleKeys.email.tr()]);
    }
  }

  static String? validatePassword(String? val, {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.length >= 6) {
      return null;
    } else {
      return LocaleKeys.invalidPasswordMessage
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    }
  }

  static String? validateConfirmPassword(String? val, String? newPassword,
      {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.length >= 6) {
      if (val == newPassword) {
        return null;
      } else {
        return LocaleKeys.doesnotMatch
            .tr(args: [label ?? LocaleKeys.confirmPassword.tr()]);
      }
    } else {
      return LocaleKeys.invalidPasswordMessage
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    }
  }

  static String? validateName(String? val) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.name.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.name.tr()]);
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    final RegExp regExp = RegExp(r'([9][678][0-6][0-9]{7})');
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [LocaleKeys.phoneNumber.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [LocaleKeys.phoneNumber.tr()]);
    } else if (val.length != 10 || !regExp.hasMatch(val)) {
      return LocaleKeys.enterValidPhoneNumber.tr();
    } else {
      return null;
    }
  }

  static String? validateFieldNotEmpty(String? val, String fieldName) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else {
      return null;
    }
  }

  static String? validateDateOfBirth(String? val) {
    if (val == null || val == "") {
      return "Date of birth field cannot be empty";
    } else if (val.isEmpty) {
      final DateTime dateTime = DateTime.parse(val);
      final maxDate = DateTime.now().year - 21;
      if (dateTime.year < maxDate) {
        return "Date of birth field cannot be empty";
      } else {
        return "Date of birth must be at least 21 years old";
      }
    } else {
      return null;
    }
  }

  static String? validateOTP(String? val, {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.otp.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.otp.tr()]);
    } else if (val.length == 4) {
      return null;
    } else {
      return LocaleKeys.otpMustBeNDigitLong.tr(args: ["4"]);
    }
  }
}
