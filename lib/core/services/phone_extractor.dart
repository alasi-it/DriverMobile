import 'package:flutter_intl_phone_field/countries.dart';

PhoneParts? extractPhoneParts(String fullNumber) {
  final cleaned = fullNumber.replaceAll(RegExp(r'[^\d]'), '');

  final sortedCountries = List.from(countries)
    ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));

  for (final country in sortedCountries) {
    final dialCode = country.dialCode;

    if (cleaned.startsWith(dialCode)) {
      return PhoneParts(
        code: dialCode,
        number: cleaned.substring(dialCode.length),
        country: country,
      );
    }
  }

  return null;
}

class PhoneParts {
  final String code;
  final String number;
  final Country country;

  PhoneParts({required this.code, required this.number, required this.country});
}
