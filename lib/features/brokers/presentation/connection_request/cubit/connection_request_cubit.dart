// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/chat_and_details_entity.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/user/domain/entities/request/complaint_request.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/res/enums/complaint_type.dart';
import 'package:waseet/res/resource.dart';

part 'connection_request_state.dart';

class ConnectionRequestCubit extends Cubit<ConnectionRequestState> {
  ConnectionRequestCubit({
    required ComplaintRepository complaintRepository,
    required CommunicationRepository communicationRepository,
  })  : _complaintRepository = complaintRepository,
        _communicationRepository = communicationRepository,
        super(const ConnectionRequestInitial()) {
    init();
  }

  final ComplaintRepository _complaintRepository;
  final CommunicationRepository _communicationRepository;
  List<ConnectionRequestEntity>? allRequests;
  List<ConnectionRequestEntity>? todayRequests;
  List<ConnectionRequestEntity>? favRequests;
  FutureOr<void> init() async {
    emit(state.copyWith(status: ConnectionRequestStatus.loading));
    try {
      final date = DateTime.now();
      final communicationRequests =
          await _communicationRepository.getRequests();
      final favCommunicationRequests =
          await _communicationRepository.getFavRequests();

      final todayCommunicationRequests =
          await _communicationRepository.getRequests(
        date:
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      );

      if (communicationRequests is ResourceSuccess &&
          favCommunicationRequests is ResourceSuccess &&
          todayCommunicationRequests is ResourceSuccess) {
        favRequests = favCommunicationRequests.data;
        favRequests?.forEach((favRequest) {
          favRequest.isFav = true;
        });

        allRequests = communicationRequests.data;
        for (final request in allRequests!) {
          for (final favRequest in favRequests!) {
            if (request.id == favRequest.id) {
              request.isFav = true;
              break;
            }
          }
        }
        todayRequests = todayCommunicationRequests.data;
        for (final request in todayRequests!) {
          for (final favRequest in favRequests!) {
            if (request.id == favRequest.id) {
              request.isFav = true;
              break;
            }
          }
        }
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.loaded,
            list: allRequests,
            favList: favRequests,
            todayList: todayRequests,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.error,
            errorMessage: communicationRequests.message,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> removeFavRequest(int id) async {
    try {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.removeLoading,
        ),
      );
      final removeMessage = await _communicationRepository.removeFavRequest(id);
      if (removeMessage is ResourceSuccess) {
        favRequests!.removeWhere((request) => request.id == id);
        for (final request in allRequests!) {
          if (request.id == id) {
            request.isFav = false;
          }
        }
        for (final request in todayRequests!) {
          if (request.id == id) {
            request.isFav = false;
          }
        }
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.addAndRemoveSuccess,
            processMessage: removeMessage.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.addAndRemoveFailure,
            errorMessage: removeMessage.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.addAndRemoveFailure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: ConnectionRequestStatus.loaded,
        errorMessage: '',
      ),
    );
  }

  Future<void> addFavRequest(int id) async {
    try {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.addLoading,
        ),
      );
      final addMessage = await _communicationRepository.addFavRequest(id);
      if (addMessage is ResourceSuccess) {
        for (final request in allRequests!) {
          if (request.id == id) {
            request.isFav = true;
            favRequests!.add(request);
          }
        }
        for (final request in todayRequests!) {
          if (request.id == id) {
            request.isFav = true;
          }
        }
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.addAndRemoveSuccess,
            processMessage: addMessage.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.addAndRemoveFailure,
            errorMessage: addMessage.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.addAndRemoveFailure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: ConnectionRequestStatus.loaded,
        errorMessage: '',
      ),
    );
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  Future<void> createComplaint({
    required int requestId,
  }) async {
    try {
      emit(state.copyWith(status: ConnectionRequestStatus.processLoading));
      final response = await _complaintRepository.createComplaint(
        ComplaintRequest(
          description: state.description ?? '',
          type: ComplaintType.communicationRequest.name,
          communicationRequestId: requestId,
        ),
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.processSuccess,
            processMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ConnectionRequestStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: ConnectionRequestStatus.loaded,
        processMessage: '',
      ),
    );
  }

  Future<void> addChatRequest(int id) async {
    emit(state.copyWith(status: ConnectionRequestStatus.startingChatLoading));
    final response = await _communicationRepository.acceptRequest(id);
    if (response is ResourceSuccess) {
      emit(
        state.copyWith(
          chatAndDetails: response.data,
          status: ConnectionRequestStatus.startingChatSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ConnectionRequestStatus.startingChatFailure,
          processMessage: response.message,
        ),
      );
    }
  }
}
