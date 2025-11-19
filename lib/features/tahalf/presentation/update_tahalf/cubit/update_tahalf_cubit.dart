// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/tahalf/domain/entities/request/create_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/resource.dart';

part 'update_tahalf_state.dart';

class UpdateTahalfCubit extends Cubit<UpdateTahalfState> {
  UpdateTahalfCubit({
    required HomeRepository homeRepository,
    required TahalfRepository tahalfRepository,
    required TahalfEntity tahalf,
  })  : _homeRepository = homeRepository,
        _tahalfRepository = tahalfRepository,
        _tahalf = tahalf,
        super(const UpdateTahalfState()) {
    init();
    emit(state.copyWith(tahalf: tahalf));
  }
  final TahalfRepository _tahalfRepository;
  final HomeRepository _homeRepository;
  final TahalfEntity _tahalf;
  Future<void> init() async {
    try {
      emit(
        state.copyWith(
          status: UpdateTahalfStatus.loading,
          selectedCategories: _tahalf.categories,
        ),
      );
      final cities = await _homeRepository.getCities(
        pageSize: 100,
      );
      final categories = await _homeRepository.getCategories();

      if (cities is ResourceSuccess && categories is ResourceSuccess) {
        emit(
          state.copyWith(
            cities: cities.data,
            categories: categories.data,
            status: UpdateTahalfStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UpdateTahalfStatus.error,
            errorMessage: cities.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UpdateTahalfStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setPassWord(String pw) {
    emit(state.copyWith(pw: pw));
  }

  Future<void> setCity(int city) async {
    emit(
      state.copyWith(
        selectedCity: city,
      ),
    );
  }

  void setSelectedCategory(List<CategoryEntity> categoryList) {
    emit(
      state.copyWith(
        selectedCategories: categoryList,
        changed: !state.changed,
      ),
    );
  }

  void setBrokerType(List<String> brokerTypesList) {
    emit(
      state.copyWith(
        selectedBrokerType: brokerTypesList,
        changed: !state.changed,
      ),
    );
  }

  void setTahalfPurpose(String tahalfPurpose) {
    emit(state.copyWith(tahalfPurpose: tahalfPurpose));
  }

  void setapprovalValue(bool approvalValue) {
    emit(state.copyWith(approval: approvalValue));
  }

  Future<void> updateTahalf() async {
    try {
      emit(state.copyWith(status: UpdateTahalfStatus.loading));
      final response = await _tahalfRepository.updateTahalf(
        CreateTahalfRequest(
          name: state.name ?? _tahalf.name!,
          wassetType: state.selectedBrokerType != null
              ? state.selectedBrokerType!.map((e) => e).toList()
              : _tahalf.wassetType!,
          city: state.selectedCity ?? _tahalf.city!.id,
          catigories: state.selectedCategories != null
              ? state.selectedCategories!.map((e) => e.id!).toList()
              : _tahalf.categories!.map((e) => e.id!).toList(),
          tahalfPurpose: state.tahalfPurpose ?? _tahalf.purpose!,
          tahalfType: state.tahalfType ?? _tahalf.purpose!,
          passWord: state.pw,
        ),
        _tahalf.id!,
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: UpdateTahalfStatus.success,
            createMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UpdateTahalfStatus.error,
            errorMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UpdateTahalfStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
