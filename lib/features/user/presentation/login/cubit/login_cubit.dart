import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:waseet/features/user/domain/entities/request/login_request.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/validators/email_validation_field.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> login() async {
    if (!state.isFormValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final result = await _authenticationRepository.loginWithEmailAndPassword(
        loginRequest: LoginRequest(
          email: state.email.value,
          password: state.password,
        ),
      );
      if (result is ResourceError) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: result.message,
          ),
        );
        emit(state.copyWith(status: FormzSubmissionStatus.initial));
        return;
      }

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void emailChanged(String value) {
    final email = EmailValidationField.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isFormValid: Formz.validate([email]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = value;
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }
}
