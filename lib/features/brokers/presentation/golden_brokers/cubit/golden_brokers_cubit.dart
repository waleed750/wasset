import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';

part 'golden_brokers_state.dart';

class GoldenBrokersCubit extends Cubit<GoldenBrokersState> {
  GoldenBrokersCubit({
    required this.repository,
  }) : super(const GoldenBrokersInitial()) {
    init();
  }

  final BrokerRepository repository;
  FutureOr<void> init() async {
    emit(
      state.copyWith(
        status: GoldenBrokersStatus.loading,
      ),
    );

    try {
      final result = await repository.getGoldenBrokers();
      if (result.errors != null) {
        emit(
          state.copyWith(
            status: GoldenBrokersStatus.error,
          ),
        );
        return;
      }

      final list = result.data;
      emit(
        state.copyWith(
          status: GoldenBrokersStatus.loaded,
          list: list,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GoldenBrokersStatus.error,
        ),
      );
      return;
    }
  }
}
