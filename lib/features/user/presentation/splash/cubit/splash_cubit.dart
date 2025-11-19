import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial()) {
    moveToNextPage();
  }
  FutureOr<void> moveToNextPage() {
    Future.delayed(const Duration(seconds: 5), () {
      emit(state.copyWith(status: SplashStatus.moving));
    });
  }
}
