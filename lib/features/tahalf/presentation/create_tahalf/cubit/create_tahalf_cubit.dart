// ignore_for_file: unused_element, avoid_positional_boolean_parameters
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
import 'package:waseet/res/enums/tahalf_purpose_type.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/resource.dart';

part 'create_tahalf_state.dart';

class CreateTahalfCubit extends Cubit<CreateTahalfState> {
  CreateTahalfCubit({
    this.tahalf,
    required HomeRepository homeRepository,
    required TahalfRepository tahalfRepository,
    required TahalfType tahalfType,
  })  : _homeRepository = homeRepository,
        _tahalfRepository = tahalfRepository,
        super(const CreateTahalfInitial()) {
    init();
    emit(state.copyWith(tahalfType: tahalfType.name));
  }
  final TahalfRepository _tahalfRepository;
  final HomeRepository _homeRepository;
  final TahalfEntity? tahalf;
  Future<void> init() async {
    try {
      emit(state.copyWith(status: CreateTahalfStatus.loading));
      final cities = await _homeRepository.getCities(
        pageSize: 100,
      );
      final categories = await _homeRepository.getCategories();

      if (cities is ResourceSuccess && categories is ResourceSuccess) {
        emit(
          state.copyWith(
            cities: cities.data,
            categories: categories.data,
            status: CreateTahalfStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CreateTahalfStatus.error,
            errorMessage: cities.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateTahalfStatus.error,
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
    //final neighborhoods = <NeighborhoodEntity>[];
    // for (final city in citiesList) {
    //   final response =
    //       await _homeRepository.getNeighborhood(city.id, pageSize: 100);
    //   if (response is ResourceSuccess) {
    //     neighborhoods.addAll(response.data!);
    //   }
    // }
    emit(
      state.copyWith(
        selectedCity: city,
      ),
    );
  }

  void setSelectedCategory(List<CategoryEntity> categoryList) {
    emit(state.copyWith(selectedCategories: categoryList));
  }

  void setBrokerType(List<BrokerType> brokerTypesList) {
    emit(state.copyWith(selectedBrokerType: brokerTypesList));
  }

  void setTahalfPurpose(TahalfPurposeType tahalfPurpose) {
    emit(state.copyWith(tahalfPurpose: tahalfPurpose));
  }

  void setapprovalValue(bool approvalValue) {
    emit(state.copyWith(approval: approvalValue));
  }

  Future<void> createTahalf() async {
    try {
      emit(state.copyWith(status: CreateTahalfStatus.loading));
      final response = await _tahalfRepository.createTahalf(
        CreateTahalfRequest(
          name: state.name ?? 'Tahalf',
          wassetType: state.selectedBrokerType?.map((e) => e.name).toList(),
          city: state.selectedCity,
          catigories: state.selectedCategories!.map((e) => e.id!).toList(),
          tahalfPurpose: state.tahalfPurpose?.name ?? '',
          tahalfType: state.tahalfType,
          passWord: state.pw,
        ),
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: CreateTahalfStatus.success,
            createMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CreateTahalfStatus.error,
            errorMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateTahalfStatus.error,
          errorMessage: 'حدث خطأ ما يرجى المحاولة لاحقا ',
          //e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: CreateTahalfStatus.loaded));
  }

  void setTahalfCategories(List<CategoryEntity> list) {
    emit(state.copyWith(selectedCategories: list));
  }
}
