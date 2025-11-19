import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:waseet/features/user/domain/entities/complaint_entity.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/res/resource.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit({
    required int userId,
    required ComplaintRepository complaintRepository,
  })  : _complaintRepository = complaintRepository,
        _userId = userId,
        super(const ComplaintInitial()) {
    init();
  }

  final int _userId;
  final ComplaintRepository _complaintRepository;
  FutureOr<void> init() async {
    try {
      emit(
        state.copyWith(
          status: ComplaintStatus.loading,
        ),
      );
      final complaints = await _complaintRepository.getComplaints(_userId);
      if (complaints is ResourceSuccess) {
        emit(
          state.copyWith(
            complaints: complaints.data,
            status: ComplaintStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: complaints.message,
            status: ComplaintStatus.error,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: ComplaintStatus.error,
        ),
      );
    }
  }
}
