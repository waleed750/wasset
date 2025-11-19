// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.errorMessage = '',
    this.email = const EmailValidationField.pure(),
    this.password = '',
    this.isFormValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final String errorMessage;
  final EmailValidationField email;
  final String password;
  final bool isFormValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props =>
      [errorMessage, email, password, isFormValid, status];

  LoginState copyWith({
    String? errorMessage,
    EmailValidationField? email,
    String? password,
    bool? isFormValid,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      isFormValid: isFormValid ?? this.isFormValid,
      status: status ?? this.status,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial() : super();
}
