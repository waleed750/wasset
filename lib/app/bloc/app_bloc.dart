import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waseet/features/user/domain/entities/about_us_model.dart';
import 'package:waseet/features/user/domain/entities/wasset_user.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/res/firebase_notifications.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AppInitial()) {
    on<AppEvent>((event, emit) {});
    on<AppStarted>(_appStarted);
    on<AppLoggedIn>((event, emit) {});
    on<AppLoggedOut>(_appLoggedOut);
    on<ChangeAccountStateEvent>(_changeAccountState);
    on<ChangeAccountTypeEvent>(_changeAccountType);
    on<UpdateAccountProfileEvent>(_updateAccountProfile);
    on<RequestNafathAuthenticationEvent>(_requestNafathAuthentication);
    on<HandleNafathNotificationEvent>(_handleNafathNotification);
    on<GetAccountProfileEvent>(_getAccountProfile);
    add(AppStarted());
  }

  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _appStarted(AppStarted event, Emitter<AppState> emit) async {
    final token = wassetSharedPreferences.getToken();
    try {
      if (token != null && token.isNotEmpty) {
        final user = await _authenticationRepository.getUser();
        if (user is ResourceSuccess) {
          try {
            String? apns = '';
            if (Platform.isIOS) {
              await FirebaseMessaging.instance.requestPermission();
              apns = await FirebaseMessaging.instance.getAPNSToken();
              if (apns == null) {
                await Future.delayed(const Duration(seconds: 3));
                apns = await FirebaseMessaging.instance.getAPNSToken();
              }
            }
            if (apns != null) {
              final token =
                  await FirebaseMessaging.instance.getTokenOrApnsToken();
              if (token != null) {
                await _authenticationRepository.updateFcmToken(token);
              }
            }
          } on Exception catch (e) {
            log(e.toString());
          }
          emit(
            state.copyWith(
              user: user.data,
              status: AppStatus.authenticated,
              isWasset: user.data?.type == UserType.wasset ? true : false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: AppStatus.unauthenticated,
              error: user.message,
              user: WassetUser.empty(),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: AppStatus.unauthenticated,
            user: WassetUser.empty(),
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          status: AppStatus.unauthenticated,
        ),
      );
      await wassetSharedPreferences.setToken('');
    }
  }

  FutureOr<void> _appLoggedOut(
    AppLoggedOut event,
    Emitter<AppState> emit,
  ) async {
    unawaited(_authenticationRepository.signOut());
    emit(state.copyWith(status: AppStatus.unauthenticated));
    add(AppStarted());
  }

  bool get isAuthenticated => state.status == AppStatus.authenticated;

  FutureOr<void> _changeAccountState(
    ChangeAccountStateEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(isBusy: !state.isBusy));
  }

  FutureOr<void> _changeAccountType(
    ChangeAccountTypeEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(isWasset: !state.isWasset));
  }

  FutureOr<void> _updateAccountProfile(
    UpdateAccountProfileEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  FutureOr<void> _requestNafathAuthentication(
    RequestNafathAuthenticationEvent event,
    Emitter<AppState> emit,
  ) async {
    await EasyLoading.show();
    try {
      final response =
          await _authenticationRepository.authNafath(event.nationalId);

      await EasyLoading.dismiss();
      if (response is ResourceSuccess) {
        event.onRequestDone?.call(response.data?.random ?? '');
      } else {
        // emit(state.copyWith(error: response.message));
        event.onException?.call(response.message ?? 'حدث خطأ ما');
        // emit(state.copyWith(error: ''));
      }
    } catch (e) {
      event.onException?.call('حدث خطأ ما');
    }
    await EasyLoading.dismiss();
  }

  FutureOr<void> _handleNafathNotification(
    HandleNafathNotificationEvent event,
    Emitter<AppState> emit,
  ) {
    log('Handling Nafath Notification ${event.data}');
  }

  FutureOr<void> _getAccountProfile(
    GetAccountProfileEvent event,
    Emitter<AppState> emit,
  ) async {
    final response = await _authenticationRepository.getUser();
    if (response is ResourceSuccess) {
      emit(state.copyWith(user: response.data));
    } else {
      emit(state.copyWith(error: response.message));
    }
  }
}
