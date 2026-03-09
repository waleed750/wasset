import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/res/resource.dart';

part 'unit_details_state.dart';

class UnitDetailsCubit extends Cubit<UnitDetailsState> {
  UnitDetailsCubit({
    required DeveloperRealEstateRepository repository,
    required int unitId,
  })  : _repository = repository,
        _unitId = unitId,
        super(const UnitDetailsState()) {
    init();
  }

  final DeveloperRealEstateRepository _repository;
  final int _unitId;

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
}
