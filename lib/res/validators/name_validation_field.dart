import 'package:formz/formz.dart';

enum NameValidationError { invalid, empty, short }

class NameValidationField extends FormzInput<String, NameValidationError> {
  const NameValidationField.pure() : super.pure('');
  const NameValidationField.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return NameValidationError.empty;
    }

    if (value!.length < 3) {
      return NameValidationError.short;
    }
    return null;
  }
}

extension NameValidationFieldX on NameValidationField {
  String? get errorMessage {
    if (error == NameValidationError.empty) {
      return 'الاسم مطلوب';
    }
    if (error == NameValidationError.short) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }
    if (error == NameValidationError.invalid) {
      return 'الاسم غير صحيح';
    }
    return null;
  }
}
