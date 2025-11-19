// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.user,
    this.error,
    this.isBusy = false,
    this.isWasset = true,
    this.aboutUs,
  });

  final AppStatus status;
  final WassetUser? user;
  final String? error;
  final bool isBusy;
  final bool isWasset;
  final AboutUsModel? aboutUs;

  @override
  List<Object?> get props => [status, user, isBusy, error, isWasset];

  AppState copyWith({
    AppStatus? status,
    WassetUser? user,
    String? error,
    bool? isBusy,
    bool? isWasset,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
      isBusy: isBusy ?? this.isBusy,
      isWasset: isWasset ?? this.isWasset,
    );
  }
}

class AppInitial extends AppState {}
