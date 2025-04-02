import 'package:email_validator/email_validator.dart';
import 'package:sport_plus/config/app_strings.dart';

class FormValidators {
  static String? confirmPasswordValidator(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppStrings.requiredText;
    } else if (confirmPassword != password) {
      return AppStrings.passwordNotConfirmed;
    }
    return null;
  }

  static String? passwordValidator(String password) {
    if (password.isEmpty) {
      return AppStrings.requiredText;
    }

    if (password.length < 8) {
      return 'Hasło musi mieć co najmniej 8 znaków';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Hasło musi zawierać co najmniej jedną cyfrę';
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(password)) {
      return 'Hasło musi zawierać co najmniej jedną literę';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Hasło musi zawierać co najmniej jeden znak specjalny';
    }

    return null;
  }

  static String? notEmpty(String value) {
    if (value.isEmpty) {
      return AppStrings.requiredText;
    }
    return null;
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return AppStrings.requiredText;
    }
    if (!EmailValidator.validate(value)) {
      return AppStrings.emailValidator;
    }
    return null;
  }
}
