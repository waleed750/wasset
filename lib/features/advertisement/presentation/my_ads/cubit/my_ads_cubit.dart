import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/brokers/domain/entities/request/get_ads_param.dart';
import 'package:waseet/res/resource.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit({
    required AdRepository adRepository,
    required int userId,
  })  : _adRepository = adRepository,
        _userId = userId,
        super(const MyAdsState()) {
    init();
  }
  final int _userId;
  final AdRepository _adRepository;
  Future<void> init() async {
    emit(state.copyWith(status: MyAdsStatus.loading));
    final ads = await _adRepository.getAds(GetAdsParam(brokerId: _userId));
    if (ads is ResourceSuccess) {
      emit(state.copyWith(status: MyAdsStatus.loaded, ads: ads.data));
    } else {
      emit(state.copyWith(status: MyAdsStatus.error));
    }
  }
}
