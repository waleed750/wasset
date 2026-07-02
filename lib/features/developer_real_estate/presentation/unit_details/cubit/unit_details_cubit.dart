import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/request/developer_unit_inquiry_request.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/res/resource.dart';

part 'unit_details_state.dart';

class UnitDetailsCubit extends Cubit<UnitDetailsState> {
  UnitDetailsCubit({
    required DeveloperRealEstateRepository repository,
    required int unitId,
    int? projectId,
  })  : _repository = repository,
        _unitId = unitId,
        _projectId = projectId,
        super(const UnitDetailsState()) {
    init();
  }

  final DeveloperRealEstateRepository _repository;
  final int _unitId;
  final int? _projectId;

  Future<void> init() async {
    try {
      emit(state.copyWith(status: UnitDetailsStatus.loading));

      final result = await _repository.getUnitById(_unitId);

      if (result is ResourceSuccess) {
        final unit = result.data;

        if (unit != null) {
          emit(
            state.copyWith(
              status: UnitDetailsStatus.loaded,
              unit: unit,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: UnitDetailsStatus.error,
              errorMessage: 'الوحدة غير موجودة',
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: UnitDetailsStatus.error,
            errorMessage: result.message ?? 'حدث خطأ ما',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UnitDetailsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<Resource<String>> submitPotentialCustomer({
    required String customerName,
    required String customerPhone,
    required int brokerId,
    required String brokerName,
  }) async {
    final projectId = state.unit?.projectId ?? _projectId;
    if (projectId == null || projectId <= 0) {
      return Resource.error('تعذر تحديد المشروع المرتبط بالوحدة');
    }

    return _repository.createPotentialCustomer(
      DeveloperUnitInquiryRequest(
        projectId: projectId,
        unitId: _unitId,
        customerName: customerName,
        customerPhone: customerPhone,
        brokerId: brokerId,
        brokerName: brokerName,
      ),
    );
  }
}
