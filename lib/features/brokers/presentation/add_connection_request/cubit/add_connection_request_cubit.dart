import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/request/connection_request.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/communication_type.dart';
import 'package:waseet/res/resource.dart';

part 'add_connection_request_state.dart';

class AddConnectionRequestCubit extends Cubit<AddConnectionRequestState> {
  AddConnectionRequestCubit({
    required HomeRepository homeRepository,
    required CommunicationRepository communicationRepository,
  })  : _homeRepository = homeRepository,
        _communicationRepository = communicationRepository,
        super(const AddConnectionRequestInitial()) {
    init();
  }
  final HomeRepository _homeRepository;
  final CommunicationRepository _communicationRepository;
  FutureOr<void> init() async {
    emit(state.copyWith(status: AddConnectionRequestStatus.loading));

    try {
      final cities = await _homeRepository.getCities(
        pageSize: 100,
      );
      final categories = await _homeRepository.getCategories();

      if (cities is ResourceSuccess && categories is ResourceSuccess) {
        final subCategories = categories.data!;
        // final allCategories =
        //     subCategories.expand((element) => element!.toList()).toList();
        emit(
          state.copyWith(
            cities: cities.data,
            // get subcategories
            categories: subCategories,
            status: AddConnectionRequestStatus.loaded,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: AddConnectionRequestStatus.error,
          errorMessage: cities.message,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AddConnectionRequestStatus.error,
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

  Future<void> addConnectionRequest() async {
    try {
      emit(state.copyWith(status: AddConnectionRequestStatus.loading));
      final response = await _communicationRepository.createRequest(
        ConnectionRequest(
          purpose: state.isForBuy ? 'buy' : 'rent',
          description: state.description,
          city: state.selectedCity,
          category: state.selectedCategory,
          communicationMethod: state.communicationMethod.name,
        ),
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: AddConnectionRequestStatus.success,
            createMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AddConnectionRequestStatus.error,
            errorMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AddConnectionRequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
