part of 'splash_cubit.dart';

enum SplashStatus { initial, moving }

class SplashState extends Equatable {
  const SplashState({
    this.status = SplashStatus.initial,
  });

  final SplashStatus status;

  @override
  List<Object> get props => [status];

  SplashState copyWith({
    SplashStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }
}

class SplashInitial extends SplashState {
  const SplashInitial() : super();
}
