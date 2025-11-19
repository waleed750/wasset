// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

class RegisterState extends Equatable with FormzMixin {
  const RegisterState({
    this.errorMessage = '',
    this.name = const NameValidationField.pure(),
    this.email = const EmailValidationField.pure(),
    this.phoneNumber = const PhoneNumberValidationField.pure(),
    this.password = const PasswordValidationField.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.gender = 'male',
    this.type = 'wasset',
    this.isFormValid = false,
  });

  final String errorMessage;
  final NameValidationField name;
  final EmailValidationField email;
  final PhoneNumberValidationField phoneNumber;
  final PasswordValidationField password;
  final FormzSubmissionStatus status;
  final String gender;
  final String type;
  final bool isFormValid;

  @override
  List<Object> get props => [
        errorMessage,
        name,
        email,
        phoneNumber,
        password,
        status,
        isFormValid,
        gender,
        type,
      ];

  RegisterState copyWith({
    String? errorMessage,
    NameValidationField? name,
    EmailValidationField? email,
    PhoneNumberValidationField? phoneNumber,
    PasswordValidationField? password,
    FormzSubmissionStatus? status,
    String? gender,
    String? type,
    bool? isFormValid,
  }) {
    return RegisterState(
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<FormzInput> get inputs => [name, email, phoneNumber, password];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial() : super();
}
