import 'dart:io';

import 'package:easy_localization/easy_localization.dart';

class AppValidators {
  /// REQUIRED VALIDATION
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else {
      return null;
    }
  }

  /// REQUIRED LENGTH VALIDATION
  static String? minLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length < length) {
      return 'validators.length.min'.tr(namedArgs: {'length': '$length'});
    } else {
      return null;
    }
  }

  /// STOCK REQUIRED LENGTH VALIDATION
  static String? stockMinLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    }
    if (int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'validators.stock_min_length'.tr();
    }
    return null;
  }

  /// MAXIMUM LENGTH VALIDATION
  static String? maxLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length > length) {
      return 'validators.length.max'.tr(namedArgs: {'length': '$length'});
    } else {
      return null;
    }
  }

  /// REQUIRED EXACT LENGTH VALIDATION
  static String? exactLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length != length) {
      return 'validators.length.exact'.tr(namedArgs: {'length': '$length'});
    } else {
      return null;
    }
  }

  /// EMAIL VALIDATION
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'validators.email.required'.tr();
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'validators.email.pattern'.tr();
    } else {
      return null;
    }
  }

  /// PASSWORD VALIDATION
  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'validators.required'.tr();
    } else if (password.length <= 6) {
      return 'validators.password_too_short'.tr();
    } else {
      return null;
    }
  }

  static String? nationalId(String? txt) {
    if (txt == null || txt.isEmpty) {
      return 'validators.required'.tr();
    }

    return null;
  }

  /// OLD PASSWORD NOT THE SAME AS NEW PASSWORD
  static String? oldPasswordNotNew(String? oldPassword, String? newPassword) {
    if (oldPassword == null || oldPassword.isEmpty) {
      return 'validators.password.required'.tr();
    } else if (newPassword == null || newPassword.isEmpty) {
      return 'validators.password.required'.tr();
    } else if (oldPassword == newPassword) {
      return 'validators.password.old_new_same'.tr();
    } else {
      return null;
    }
  }

  /// PASSWORD IDENTICAL
  static String? passwordIdentical(String? value, String? other) {
    if (value == null || value.isEmpty) {
      return 'validators.password.required'.tr();
    } else if (value != other) {
      return 'validators.password.identical'.tr();
    } else {
      return null;
    }
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.required'.tr();
    }

    final trimmed = value.trim();
    final words = trimmed.split(RegExp(r'\s+'));

    // لازم كلمتين بالظبط
    if (words.length != 2) {
      return 'validators.full_name_two_words'.tr();
    }

    // كل كلمة لازم تكون حروف فقط
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF]+$');

    if (!nameRegex.hasMatch(words[0]) || !nameRegex.hasMatch(words[1])) {
      return 'validators.name_invalid'.tr();
    }

    return null;
  }

  /// PHONE NUMBER VALIDATION
  ///
  ///
  ///
  String? phone(String number, int minLength, int maxLength) {
    final trimmed = number.trim();
    if (trimmed.isEmpty) return 'validators.phone.phone_required'.tr();
    if (trimmed.length < minLength)
      return '${'validators.phone.phone_too_short'.tr()} ${minLength.toString()}';
    if (trimmed.length > maxLength)
      return '${'validators.phone.phone_too_long'.tr()} ${maxLength.toString()}';
    return null;
  }

  static String? phoneValidation(String? value, bool isValid) {
    if (value == null || value.isEmpty) {
      return 'validators.phone.required'.tr();
    } else if (!isValid) {
      return 'validators.phone.invalid'.tr();
    } else {
      return null;
    }
  }

  /// ONLY NUMBERS AND LENGTH
  static String? onlyNumbers(String? value, {int? length}) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else if (length != null && value.length != length) {
      return 'validators.numbers.exact_length'.tr(
        namedArgs: {'length': '$length'},
      );
    } else {
      return null;
    }
  }

  /// NUMBER LESS THAN VALIDATION
  static String? numLessThan(String? value, int max) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else {
      int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'validators.numbers.only'.tr();
      } else if (intValue >= max) {
        return 'validators.numbers.less_than'.tr(namedArgs: {'max': '$max'});
      } else {
        return null;
      }
    }
  }

  /// VALUE IN RANGE VALIDATION
  static String? numInRange(String? value, int min, int max) {
    if (value == null || value.isEmpty) {
      if (min == max) {
        return "This Commit Quantity Is Completed";
      }
      return 'validators.required'.tr();
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    }

    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'validators.numbers.only'.tr();
    }
    if (intValue < min || intValue > max) {
      return 'validators.numbers.range'.tr(
        namedArgs: {'min': '$min', 'max': '$max'},
      );
    }

    return null;
  }
  // static String? numInRange(String? value, int min, int max) {
  //   if (value == null || value.isEmpty) {
  //     return 'validators.required'.tr();
  //   } else if (!RegExp(r'^\d+$').hasMatch(value)) {
  //     return 'validators.numbers.only'.tr();
  //   } else {
  //     int? intValue = int.tryParse(value);
  //     if (intValue == null) {
  //       return 'validators.numbers.only'.tr();
  //     } else if (intValue < min || intValue > max) {
  //       return 'validators.numbers.range'.tr(
  //         namedArgs: {'min': '$min', 'max': '$max'},
  //       );
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  /// NUMBER GREATER THAN VALIDATION
  static String? numGreaterThan(String? value, int min) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else {
      int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'validators.numbers.only'.tr();
      } else if (intValue <= min) {
        return 'validators.numbers.greater_than'.tr(namedArgs: {'min': '$min'});
      } else {
        return null;
      }
    }
  }

  /// OTP VALIDATION
  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.OTP.required'.tr();
    } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'validators.OTP.length'.tr();
    } else {
      return null;
    }
  }

  static String? fileRequired(File? file) {
    if (file == null) {
      return 'validators.files.required'.tr();
    }
    return null;
  }

  static String? dropdown<T>(T? value) {
    if (value == null) {
      return 'validators.required'.tr();
    }
    return null;
  }
}
