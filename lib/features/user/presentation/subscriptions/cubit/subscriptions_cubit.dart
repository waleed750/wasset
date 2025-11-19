import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/user/domain/entities/subscription/my_subscription_entity.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/res/resource.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  SubscriptionsCubit({
    required AuthenticationRepository repository,
  })  : _repository = repository,
        super(const SubscriptionsState()) {
    getSubscriptions();
  }

  final AuthenticationRepository _repository;

  Future<void> getSubscriptions() async {
    emit(
      state.copyWith(
        status: SubscriptionsStatus.loading,
      ),
    );
    try {
      final result = await _repository.getMySubscriptions();
      if (result is ResourceSuccess) {
        emit(
          state.copyWith(
            status: SubscriptionsStatus.loaded,
            subscriptions: result.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SubscriptionsStatus.error,
            error: result.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SubscriptionsStatus.error,
          error: e.toString(),
        ),
      );
    }
  }
}
