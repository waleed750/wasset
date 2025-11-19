import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/domain/entities/request/package_subscribe_request.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/resource.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit({
    PackagesEntity? package,
    required HomeRepository homeRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _package = package,
        _homeRepository = homeRepository,
        _authenticationRepository = authenticationRepository,
        super(const PackagesState()) {
    init();
  }

  final HomeRepository _homeRepository;
  final AuthenticationRepository _authenticationRepository;
  final PackagesEntity? _package;

  /// A description for yourCustomFunction
  FutureOr<void> init() async {
    emit(state.copyWith(status: PackagesStatus.loading));
    try {
      final result = await _homeRepository.getPackages();

      if (result is ResourceSuccess) {
        emit(
          state.copyWith(
            status: PackagesStatus.success,
            packages: result.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PackagesStatus.failure,
            message: result.message,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: PackagesStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  void selectPackage(PackagesEntity package) {
    emit(state.copyWith(selectedPackage: package));
  }

  Future<String> getPaymentLink(
    String name,
    String cardNumber,
    String year,
    String month,
    String cvv,
    String mobile,
  ) async {
    // emit(state.copyWith(status: PackagesStatus.loading));
    try {
      final result = await _authenticationRepository.subscribeToPackage(
        PackageSubscribeRequest(
          packageId: state.selectedPackage!.id!.toString(),
          type: 'credit_card',
          amount: state.selectedPackage!.price!,
          name: name,
          number: cardNumber,
          cvc: cvv,
          month: month,
          year: year,
          mobile: mobile,
        ),
      );

      if (result is ResourceSuccess) {
        return result.data?.payment?.sourceTransactionUrl ?? '';
      } else {
        emit(
          state.copyWith(
            status: PackagesStatus.failure,
            message: result.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PackagesStatus.failure,
          message: e.toString(),
        ),
      );
    }
    return '';
  }
}
