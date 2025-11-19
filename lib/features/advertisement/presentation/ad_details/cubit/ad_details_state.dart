part of 'ad_details_cubit.dart';

enum AdDetailsStatus { initial, loading, loaded, error }

class AdDetailsState extends Equatable {
  const AdDetailsState({
    this.message = '',
    this.ad,
    this.status = AdDetailsStatus.initial,
  });

  final String message;
  final AdEntity? ad;
  final AdDetailsStatus status;

  @override
  List<Object?> get props => [message, ad, status];

  AdDetailsState copyWith({
    String? message,
    AdEntity? ad,
    AdDetailsStatus? status,
  }) {
    return AdDetailsState(
      message: message ?? this.message,
      ad: ad ?? this.ad,
      status: status ?? this.status,
    );
  }
}
