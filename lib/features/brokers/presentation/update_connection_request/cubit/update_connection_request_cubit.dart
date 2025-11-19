// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/entities/request/connection_request.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/communication_type.dart';
import 'package:waseet/res/resource.dart';
part 'update_connection_request_state.dart';

class UpdateConnectionRequestCubit extends Cubit<UpdateConnectionRequestState> {
  UpdateConnectionRequestCubit({
    required ConnectionRequestEntity request,
    required HomeRepository homeRepository,
    required CommunicationRepository communicationRepository,
  })  : _request = request,
        _homeRepository = homeRepository,
        _communicationRepository = communicationRepository,
        super(const UpdateConnectionRequestInitial()) {
    init();
    emit(
      state.copyWith(
        request: _request,
        communicationMethod: _request.communicationMethod ==
                CommunicationMethod.call.name
            ? CommunicationMethod.call
            : _request.communicationMethod == CommunicationMethod.message.name
                ? CommunicationMethod.message
                : CommunicationMethod.whats,
        isForBuy: _request.purpose == 'buy' ? true : false,
      ),
    );
  }
  final ConnectionRequestEntity _request;
  final HomeRepository _homeRepository;
  final CommunicationRepository _communicationRepository;
  FutureOr<void> init() async {
    emit(state.copyWith(status: UpdateConnectionRequestStatus.loading));

    try {
      final cities = await _homeRepository.getCities(
        pageSize: 100,
      );
      final categories = await _homeRepository.getCategories();

      if (cities is ResourceSuccess && categories is ResourceSuccess) {
        emit(
          state.copyWith(
            cities: cities.data,
            categories: categories.data,
            status: UpdateConnectionRequestStatus.loaded,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: UpdateConnectionRequestStatus.error,
          errorMessage: cities.message,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: UpdateConnectionRequestStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void setPurpose({required bool isForBuy}) {
    emit(
      state.copyWith(
        isForBuy: isForBuy,
      ),
    );
  }

  Future<void> setCity(int city) async {
    emit(
      state.copyWith(
        selectedCity: city,
      ),
    );
  }

  void setCategory(int category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void setCommunitionMethod(CommunicationMethod communicationMethod) {
    emit(state.copyWith(communicationMethod: communicationMethod));
  }

  Future<void> updateConnectionRequest() async {
    try {
      emit(state.copyWith(status: UpdateConnectionRequestStatus.loading));
      final response = await _communicationRepository.updateRequest(
        ConnectionRequest(
          purpose: state.isForBuy ? 'buy' : 'rent',
          description: state.description ?? _request.description,
          city: state.selectedCity ?? _request.city.id,
          category: state.selectedCategory ?? _request.category.id,
          communicationMethod: state.communicationMethod.name,
        ),
        _request.id,
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: UpdateConnectionRequestStatus.success,
            createMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UpdateConnectionRequestStatus.error,
            errorMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UpdateConnectionRequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
