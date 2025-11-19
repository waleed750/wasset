import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:waseet/features/user/domain/entities/request/register_request.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/validators/email_validation_field.dart';
import 'package:waseet/res/validators/name_validation_field.dart';
import 'package:waseet/res/validators/password_validation_field.dart';
import 'package:waseet/res/validators/saudi_phone_number_validation_field.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    log('RegisterCubit');
  }

  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    final name = NameValidationField.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isFormValid: Formz.validate(
          [
            name,
            state.email,
            state.phoneNumber,
            state.password,
          ],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = EmailValidationField.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isFormValid: Formz.validate(
          [
            state.name,
            email,
            state.phoneNumber,
            state.password,
          ],
        ),
      ),
    );
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumberValidationField.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isFormValid: Formz.validate(
          [
            state.name,
            state.email,
            phoneNumber,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = PasswordValidationField.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isFormValid: Formz.validate(
          [
            state.name,
            state.email,
            state.phoneNumber,
            password,
          ],
        ),
      ),
    );
  }

  void genderChanged(String value) {
    emit(
      state.copyWith(
        gender: value,
      ),
    );
  }

  void typeChanged(String value) {
    emit(
      state.copyWith(
        type: value,
      ),
    );
  }

  Future<void> register() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final result =
          await _authenticationRepository.registerWithEmailAndPassword(
        registerRequest: RegisterRequest(
          name: state.name.value,
          email: state.email.value,
          password: state.password.value,
          phone: state.phoneNumber.value,
          type: state.type,
          gender: state.gender,
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
}
