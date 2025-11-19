import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/notification_entity.dart';
import 'package:waseet/features/user/domain/entities/slide_entity.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/resource.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const HomePageInitial()) {
    init();
  }
  final HomeRepository _homeRepository;

  FutureOr<void> init() async {
    emit(
      state.copyWith(
        status: HomePageStatus.loading,
      ),
    );
    try {
      final cities = await _homeRepository.getCities();
      final sliders = await _homeRepository.getSlider();
      final nothfication = await _homeRepository.getNotifications();

      if (cities is ResourceSuccess &&
          sliders is ResourceSuccess &&
          nothfication is ResourceSuccess) {
        final unreadNothfication = nothfication.data?.where(
          (element) {
            return element.readAt != null;
          },
        ).toList();
        emit(
          state.copyWith(
            unreadNothfication: unreadNothfication,
            cities: cities.data,
            sliders: sliders.data,
            status: HomePageStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            cities: cities is ResourceSuccess ? cities.data : [],
            sliders: sliders is ResourceSuccess ? sliders.data : [],
            status: HomePageStatus.error,
            errorMessage: cities.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomePageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
