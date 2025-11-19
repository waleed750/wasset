part of 'my_ads_cubit.dart';

enum MyAdsStatus { initial, loading, loaded, error }

class MyAdsState extends Equatable {
  const MyAdsState({
    this.status = MyAdsStatus.initial,
    this.ads = const <AdEntity>[],
  });

  final MyAdsStatus status;
  final List<AdEntity> ads;

  MyAdsState copyWith({
    MyAdsStatus? status,
    List<AdEntity>? ads,
  }) {
    return MyAdsState(
      status: status ?? this.status,
      ads: ads ?? this.ads,
    );
  }

  @override
  List<Object> get props => [status, ads];
}
