part of 'home_page_cubit.dart';

enum HomePageStatus { initial, loading, loaded, error }

@immutable
class HomePageState extends Equatable {
  const HomePageState({
    this.errorMessage = '',
    this.cities = const [],
    this.sliders = const [],
    this.unreadNothfication = const [],
    this.status = HomePageStatus.initial,
  });

  final String errorMessage;
  final List<CitiesEntity> cities;
  final List<SliderEntity> sliders;
  final HomePageStatus status;
  final List<NotificationEntity> unreadNothfication;

  @override
  List<Object?> get props =>
      [errorMessage, cities, sliders, status, unreadNothfication];

  HomePageState copyWith({
    String? errorMessage,
    List<CitiesEntity>? cities,
    List<SliderEntity>? sliders,
    List<NotificationEntity>? unreadNothfication,
    HomePageStatus? status,
  }) {
    return HomePageState(
      errorMessage: errorMessage ?? this.errorMessage,
      cities: cities ?? this.cities,
      sliders: sliders ?? this.sliders,
      unreadNothfication: unreadNothfication ?? this.unreadNothfication,
      status: status ?? this.status,
    );
  }
}

class HomePageInitial extends HomePageState {
  const HomePageInitial() : super();
}
