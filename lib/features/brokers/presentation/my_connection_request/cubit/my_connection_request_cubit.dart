import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/res/resource.dart';

part 'my_connection_request_state.dart';

class MyConnectionRequestCubit extends Cubit<MyConnectionRequestState> {
  MyConnectionRequestCubit({
    required int userId,
    required CommunicationRepository communicationRepository,
  })  : _communicationRepository = communicationRepository,
        _userId = userId,
        super(const MyConnectionRequestInitial()) {
    init();
  }
  final int _userId;
  final CommunicationRepository _communicationRepository;
  List<ConnectionRequestEntity> requestsList = [];
  Future<void> init() async {
    try {
      emit(state.copyWith(status: MyConnectionRequestStatus.loading));
      final myRequests = await _communicationRepository.getRequests(
        userID: _userId,
      );
      if (myRequests is ResourceSuccess) {
        requestsList = myRequests.data!;
        emit(
          state.copyWith(
            list: myRequests.data,
            status: MyConnectionRequestStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: MyConnectionRequestStatus.error,
            errorMessage: myRequests.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: MyConnectionRequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteRequest(int requestId) async {
    try {
      emit(state.copyWith(status: MyConnectionRequestStatus.processLoading));
      final response = await _communicationRepository.deleteRequest(requestId);
      if (response is ResourceSuccess) {
        requestsList.removeWhere((request) => request.id == requestId);
        emit(
          state.copyWith(
            status: MyConnectionRequestStatus.processSuccess,
            list: requestsList,
            processMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: MyConnectionRequestStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: MyConnectionRequestStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
  }

  void update() {
    requestsList.clear();
    init();
  }
}
