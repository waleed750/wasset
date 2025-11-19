import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid, empty }

class PhoneNumberValidationField
    extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberValidationField.pure() : super.pure('');
  const PhoneNumberValidationField.dirty([super.value = '']) : super.dirty();

  static final _phoneNumberRegex = RegExp(
    '^5[0-9]{8}',
  );

  @override
  PhoneNumberValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return PhoneNumberValidationError.empty;
    }
    if (!_phoneNumberRegex.hasMatch(value ?? '')) {
      return PhoneNumberValidationError.invalid;
    }
    return null;
  }
}

extension PhoneNumberValidationFieldX on PhoneNumberValidationField {
  String? get errorMessage {
    if (error == PhoneNumberValidationError.empty) {
      return 'الرجاء ادخال رقم الجوال';
    }
    if (error == PhoneNumberValidationError.invalid) {
      return 'رقم الجوال غير صحيح';
    }
    return null;
  }
}
