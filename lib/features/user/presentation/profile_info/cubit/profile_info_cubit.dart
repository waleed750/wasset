import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/request/update_profile_request.dart';
import 'package:waseet/features/user/domain/entities/wasset_user.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/features/user/presentation/profile_info/profile_info.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/validators/email_validation_field.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit({
    required HomeRepository homeRepository,
    required AuthenticationRepository authenticationRepository,
    WassetUser? profile,
  })  : _homeRepository = homeRepository,
        _authenticationRepository = authenticationRepository,
        super(
          ProfileInfoState(
            email: EmailValidationField.dirty(profile?.email ?? ''),
            name: profile?.name ?? '',
            identityNumber: profile?.profile?.identityNumber ?? '',
            licenseNumber: profile?.profile?.licenseNumber ?? '',
            officeName: profile?.profile?.officeName ?? '',
            officeType:
                profile?.profile?.officeType?.toBrokerType ?? BrokerType.wasset,
            brokerSpecialization: profile?.profile?.wassetSpecialization,
            citiesList: profile?.profile?.cities,
            phone: profile?.phone ?? '',
          ),
        ) {
    _profile = profile;
    getCities();
  }

  WassetUser? _profile;

  final HomeRepository _homeRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> getCities() async {
    try {
      emit(state.copyWith(status: ProfileInfoStatus.loading));
      final cities = await _homeRepository.getCities(pageSize: 1000);
      final categories = await _homeRepository.getCategories(pageSize: 1000);
      if (cities is ResourceSuccess && categories is ResourceSuccess) {
        emit(
          state.copyWith(
            cities: cities.data,
            categories: categories.data,
            status: ProfileInfoStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ProfileInfoStatus.error,
            errorMessage: cities.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileInfoStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setBrokerType(BrokerType brokerType) {
    emit(state.copyWith(officeType: brokerType));
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setIdentityNumber(String identityNumber) {
    emit(state.copyWith(identityNumber: identityNumber));
  }

  void setLicenseNumber(String licenseNumber) {
    emit(state.copyWith(licenseNumber: licenseNumber));
  }

  void setEmail(String email) {
    emit(state.copyWith(email: EmailValidationField.dirty(email)));
  }

  void setOfficeName(String officeName) {
    emit(state.copyWith(officeName: officeName));
  }

  void setBrokerSpecialization(List<CategoryEntity> brokerSpecialization) {
    emit(state.copyWith(brokerSpecialization: brokerSpecialization));
  }

  void setCities(List<CitiesEntity> cities) {
    emit(state.copyWith(citiesList: cities));
  }

  void setSelectedCategory(CategoryEntity category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setPhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  Future<void> updateProfile() async {
    try {
      emit(state.copyWith(status: ProfileInfoStatus.updating));
      final response = await _authenticationRepository.updateProfile(
        UpdateProfileRequest(
          name: state.name ?? _profile?.name ?? '',
          email: state.email.value.isNotEmpty
              ? state.email.value
              : _profile?.email ?? '',
          identityNumber:
              state.identityNumber ?? _profile?.profile?.identityNumber ?? '',
          licenseNumber:
              state.licenseNumber ?? _profile?.profile?.licenseNumber ?? '',
          wassetSpecialization:
              state.brokerSpecialization?.map((e) => e.id!).toList() ??
                  _profile?.profile?.wassetSpecialization
                      ?.map((e) => e.id!)
                      .toList() ??
                  [],
          officeName: state.officeName ?? _profile?.profile?.officeName ?? '',
          officeType:
              state.officeType?.name ?? _profile?.profile?.officeType ?? '',
          cities: state.citiesList?.map((e) => e.id).toList().cast<int>() ??
              _profile?.profile?.cities
                  ?.map((e) => e.id)
                  .toList()
                  .cast<int>() ??
              [],
          phone: state.phone ?? _profile?.phone ?? '',
          isBroker: _profile?.isBroker ?? false,
        ),
      );
      if (response is ResourceSuccess) {
        final response = await _authenticationRepository.getUser();
        if (response is ResourceSuccess) {
          _profile = response.data;
        }
        emit(
          state.copyWith(
            status: ProfileInfoStatus.updated,
            profile: _profile,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ProfileInfoStatus.error,
            errorMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileInfoStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ProfileInfoStatus.loaded));
  }

  Future<void> update(File picked) async {
    emit(state.copyWith(status: ProfileInfoStatus.updating));
    final response = await _authenticationRepository.updateProfileImage(
      picked,
      _profile?.isBroker ?? true,
    );
    if (response is ResourceSuccess) {
      emit(
        state.copyWith(
          status: ProfileInfoStatus.updated,
          profile: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ProfileInfoStatus.error,
          errorMessage: response.message,
          profile: response.data,
        ),
      );
    }
    emit(state.copyWith(status: ProfileInfoStatus.loaded));
  }
}
