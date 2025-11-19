import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:waseet/features/user/domain/entities/notification_entity.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/resource.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const NotificationsInitial()) {
    init();
  }
  final HomeRepository _homeRepository;
  FutureOr<void> init() async {
    try {
      emit(
        state.copyWith(
          status: NotificationStatus.loading,
        ),
      );
      final notifications = await _homeRepository.getNotifications();
      if (notifications is ResourceSuccess) {
        emit(
          state.copyWith(
            notifications: notifications.data,
            status: NotificationStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: notifications.message,
            status: NotificationStatus.error,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: NotificationStatus.error,
        ),
      );
    }
  }
}
