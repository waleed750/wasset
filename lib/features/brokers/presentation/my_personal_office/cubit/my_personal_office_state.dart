// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'my_personal_office_cubit.dart';

enum MyPersonalOfficeStatus { initial, loading, loaded, error }

class MyPersonalOfficeState extends Equatable {
  const MyPersonalOfficeState({
    this.customProperty = '',
    this.ads = const [],
    this.status = MyPersonalOfficeStatus.initial,
    this.posts = const [],
    this.isChanged = false,
    this.isUserProfile = false,
    this.wassetProfile,
  });

  final String customProperty;
  final List<AdEntity> ads;
  final MyPersonalOfficeStatus status;
  final List<PostEntity> posts;
  final bool isChanged;
  final bool isUserProfile;
  final WassetProfileEntity? wassetProfile;

  @override
  List<Object?> get props => [
        customProperty,
        ads,
        status,
        posts,
        isChanged,
        isUserProfile,
        wassetProfile
      ];

  MyPersonalOfficeState copyWith({
    String? customProperty,
    List<AdEntity>? ads,
    MyPersonalOfficeStatus? status,
    List<PostEntity>? posts,
    bool? isChanged,
    bool? isUserProfile,
    WassetProfileEntity? wassetProfile,
  }) {
    return MyPersonalOfficeState(
      customProperty: customProperty ?? this.customProperty,
      ads: ads ?? this.ads,
      status: status ?? this.status,
      posts: posts ?? this.posts,
      isChanged: isChanged ?? this.isChanged,
      isUserProfile: isUserProfile ?? this.isUserProfile,
      wassetProfile: wassetProfile ?? this.wassetProfile,
    );
  }
}
