import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/res/resource.dart';

part 'ad_details_state.dart';

class AdDetailsCubit extends Cubit<AdDetailsState> {
  AdDetailsCubit({
    required AdRepository adRepository,
    AdEntity? ad,
    int adId = 0,
  })  : _adRepository = adRepository,
        super(const AdDetailsState()) {
    init(ad, adId);
  }

  final AdRepository _adRepository;

  /// A description for yourCustomFunction
  FutureOr<void> init(AdEntity? ad, int adId) async {
    emit(state.copyWith(status: AdDetailsStatus.loading));
    var iAd = ad;
    if (ad == null) {
      final result = await _adRepository.getAdById(adId);
      if (result is ResourceSuccess) {
        iAd = result.data;
      } else {
        return emit(state.copyWith(status: AdDetailsStatus.error));
      }
    }
    emit(state.copyWith(status: AdDetailsStatus.loaded, ad: iAd));
  }
}
